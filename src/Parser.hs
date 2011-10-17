module Parser where

import AST
import UU.Parsing
import ParseToken

parser tokens = parseIO pRoot tokens

pRoot = sem_Root_Root <$> pProgram

pProgram  = sem_Program_Program   <$> pCompstmt1 <* pEOF

pCompstmt1 = sem_Compstmt_Cons <$> pStmt 
                               <*  pEOL
                               <*> pCompstmt0

pCompstmt0 = pFoldr (sem_Compstmt_Cons,sem_Compstmt_Nil) (pStmt <* pEOL)

pStmt     =    sem_Stmt_CallS     <$> pCall
                                  <*> pStmtWithModif
                                      
           <|> sem_Stmt_Undef     <$  pPalRes "undef"
                                  <*> pID
                                  <*> pStmtWithModif
                                  
           <|> sem_Stmt_Alias     <$  pPalRes "alias"
                                  <*> pID
                                  <*> pID
                                  <*> pStmtWithModif
                                  
           <|> sem_Stmt_Begin     <$  pPalRes "BEGIN"
                                  <*  pSeparador "{"
                                  <*> pCompstmt0
                                  <*  pSeparador "}"
                                  <*> pStmtWithModif
                                  
           <|> sem_Stmt_End       <$  pPalRes "END"
                                  <*  pSeparador "{"
                                  <*> pCompstmt0
                                  <*  pSeparador "}"
                                  <*> pStmtWithModif
                                  
          <|> sem_Stmt_ExprS      <$> pExpr
                                  <*> pStmtWithModif
                                  
pStmtWithModif = sem_StmtWithModif_If      <$  pPalRes "if" 
                                           <*> pExpr
                                           <*> pStmtWithModif
                                  
              <|> sem_StmtWithModif_While  <$  pPalRes "while"
                                           <*> pExpr 
                                           <*> pStmtWithModif
            
              <|> sem_StmtWithModif_Unless <$  pPalRes "unless"
                                           <*> pExpr
                                           <*> pStmtWithModif
                                  
              <|> sem_StmtWithModif_Until  <$  pPalRes "until"
                                           <*> pExpr
                                           <*> pStmtWithModif
                                  
              <|> pSucceed sem_StmtWithModif_NilStmt

pCall =     sem_Call_Function <$> pFunction

pFunction = sem_Function_Function <$> pID <*> pCallArguments

pCallArguments =   pSeparador "(" *> pCall_ArgsFs <*  pSeparador ")"
               <|> pCall_ArgsFs

pCall_ArgsFs = pFoldrSep_ng (sem_Call_ArgsFs_Cons,sem_Call_ArgsFs_Nil) (pSeparador ",") pCall_ArgsF

pCall_ArgsF  = sem_Call_ArgsF_Call_ArgsFs  <$> pArg

pExpr = foldr pChainr pFactorExpr [pOr,pAnd]

-- para que el operador vaya al medio es necesario poner lambda jcar
pOr  = (\o1 o2 -> sem_Expr_OpExpr o1 sem_OpE_OrExpr o2 ) <$  pPalRes "or"
pAnd = (\o1 o2 -> sem_Expr_OpExpr o1 sem_OpE_AndExpr o2) <$  pPalRes "and"

pFactorExpr
          =    sem_Expr_ReturnExpr   <$  pPalRes "return"
                                     <*> pCall_Args

           <|> sem_Expr_YieldExpr    <$  pPalRes "yield"
                                     <*> pCall_Args

           <|> sem_Expr_NotExpr      <$  pPalRes "not"
                                     <*> pExpr

           <|> sem_Expr_CommandExpr  <$> pFunction

           <|> sem_Expr_ArgExpr      <$> pArg

pCall_Args = pFoldrSep_ng (sem_Call_Args_Cons,sem_Call_Args_Nil) (pSeparador ",") pCall_Arg

pCall_Arg =     sem_Call_Arg_Integer  <$> pEntero
            <|> sem_Call_Arg_String   <$> pCadena
            <|> sem_Call_Arg_Identif  <$> pID
                                  
pPrimary =     sem_Primary_Paren        <$  pSeparador "("
                                        <*> pCompstmt0
                                        <*> pZ3
                                        <*  pSeparador ")"

           <|> sem_Primary_Variable     <$> pVariable
                                        <*> pZ3

           <|> sem_Primary_ColonColon   <$  pOperador "::"
                                        <*> pID
                                        <*> pZ3

           <|> sem_Primary_ReturnYield  <$  pSeparador "("
                                        <*> pReturnYield
                                        <*> pZ3
                                        <*  pSeparador ")"

           <|> sem_Primary_DefinedP     <$  pPalRes "defined?"
                                        <*> pArg
                                        <*> pZ3

           <|> sem_Primary_If_P         <$  pPalRes "if"
                                        <*> pExpr
                                        <*> pThen
                                        <*> pCompstmt0
                                        <*> pElsIf
                                        <*> pElse
                                        <*  pPalRes "end"
                                        <*> pZ3

           <|> sem_Primary_While_P     <$  pPalRes "while"
                                       <*> pExpr
                                       <*> pDo
                                       <*> pCompstmt0
                                       <*  pPalRes "end"
                                       <*> pZ3

           <|> sem_Primary_Show        <$> pVariable
                                       <*> pVariable
                                       <*> pZ3
 
           <|> sem_Primary_For_P       <$  pPalRes "for"
                                       <*> pBlock_Var
                                       <*> pExpr
                                       <*> pDo
                                       <*> pCompstmt0
                                       <*  pPalRes "end"
                                       <*> pZ3

           <|> sem_Primary_Class       <$  pPalRes "class"
                                       <*> pCID
                                       <*> pHereda
                                       <*> pCompstmt0
                                       <*> pZ3
                                       <*  pPalRes "end"

           <|> sem_Primary_Definition  <$  pPalRes "def"
                                       <*> pID
                                       <*> pDefArgs
                                       <*> pCompstmt0
                                       <*> pZ3
                                       <*  pPalRes "end"

           <|> sem_Primary_FunctionP   <$> pFunction
                                       <*> pZ3

pBlock_Var = sem_Block_Var_Block_Var_Lhs <$> pLhsB

pLhsB      = sem_LhsB_Lhs_id <$> pID

pDo =     sem_Do_DoSemiColon   <$ pEOL
      <|> sem_Do_DoDo          <$ pPalRes "do"
      <|> sem_Do_DoSemiColonDo <$ pEOL
                               <* pPalRes "do"

pThen =     sem_Then_ThSemiColon     <$ pEOL

        <|> sem_Then_ThThen          <$ pPalRes "then"
        
        <|> sem_Then_ThSemiColonThen <$ pEOL
                                    <* pPalRes "then"

pElsIf =     sem_ElsIf_ElsIf    <$ pPalRes "elsif"
                                <*> pExpr
                                <*> pThen
                                <*> pCompstmt0
                                
         <|> pSucceed sem_ElsIf_NilElsIf
         
pElse =     sem_Else_Else    <$  pPalRes "else"
                             <*> pCompstmt0
        <|> pSucceed sem_Else_NilElse

pReturnYield =     sem_ReturnYield_ReturnR <$ pPalRes "return" <*> pCall_Args
               <|> sem_ReturnYield_YieldY  <$ pPalRes "yield"  <*> pCall_Args

pVariable =     sem_Variable_Identifv <$> pID
            <|> sem_Variable_Int      <$> pEntero
            <|> sem_Variable_Str      <$> pCadena

pArg = foldr pChainr pFactorArg [ pOpBooleanosO, pOpBooleanosY, pOpRelacionales
                                , pOpSuma, pOpMult, pOpCall
								]

opsBooleanosO   = ["||"]
opsBooleanosY   = ["&&"]
opsRelacionales = ["<",">",">=","<=","==","!=","<>"]
opsSuma         = ["+","-"]
opsMult         = ["*","/","%"]
opsCall         = ["."]

pOpBooleanosO   = pOpGen opsBooleanosO
pOpBooleanosY   = pOpGen opsBooleanosY
pOpRelacionales = pOpGen opsRelacionales
pOpSuma         = pOpGen opsSuma
pOpMult         = pOpGen opsMult
pOpCall         = pOpGen opsCall

pOpGen' f ops = foldr1 (<|>) (map (\op -> f <$> pOperador op) ops)

pOpGen ops = pOpGen' sem_Arg_ArgOpBin ops

pFactorArg
  =   sem_Arg_ArgAsig     <$> pID
                          <*> pOp_Asgn
                          <*> pArg
  
  <|> sem_Arg_ArgOpUn     <$> pOp_Un <*> pArg
                        
  <|> sem_Arg_ArgDefined  <$  pPalRes "defined?"
                          <*> pArg

  <|> pSeparador "(" *> pArg <* pSeparador ")"
                           
  <|> sem_Arg_ArgPrimary  <$> pPrimary

pOp_Asgn = pOpGen' id ["=", "+=", "-=", "*=", "/="]
pOp_Un   = pOpGen' id ["+", "-", "~", "!"]

pHereda =   sem_Inherits_Nothing <$ pEOL
        <|> sem_Inherits_Just    <$ pOperador "<" <*> pCID <* pEOL

pZ3 =     sem_Z3_Ident <$ pSeparador "::" <*> pID <*> pZ3
      <|> sem_Z3_ArgZ3 <$ pSeparador "["
                       <*> pArg 
                       <*  pSeparador "]"
                       <*> pZ3
      <|> pSucceed sem_Z3_NilZ3

pDefArgs =   (pSeparador "(" *> pArgDecls <*  pSeparador ")" <* pOptEOL)
         <|> pArgDecls <* pEOL

pArgDecls = pFoldrSep_ng (sem_ArgDecls_Cons, sem_ArgDecls_Nil) (pSeparador "," <* pOptEOL) pArgDecl

pArgDecl = sem_ArgDecl_ArgDecl <$> pID

pOptEOL = pEOL `opt` ""

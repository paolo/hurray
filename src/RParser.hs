module RParser where

import AST
import UU.Parsing
import TokenParser

parser tokens = parseIO pRoot tokens

-- Root
pRoot = sem_Root_Root <$> pProgram

-- Program
pProgram = sem_Program_Program <$> pCompStmt <* pEOF

-- CompStmt
pCompStmt  = sem_CompStmt_Cons <$> pStmt
                               <*  pEOL
                               <*> pCompStmt'
pCompStmt' = pFoldr (sem_CompStmt_Cons,sem_CompStmt_Nil) (pStmt <* pEOL)

-- Stmt
pStmt  =  sem_Stmt_Alias  <$  pKeyword "alias"
                          <*> pAliasStmt
                          <*> pStmtWModif
      <|> sem_Stmt_Undef  <$  pKeyword "undef"
                          <*> pUndefParams 
                          <*> pStmtWModif
      <|> sem_Stmt_KBegin <$  pKeyword "BEGIN"
                          <*  pPunctuator "{"
                          <*> pCompStmt
                          <*  pPunctuator "}"
                          <*> pStmtWModif
      <|> sem_Stmt_KEnd   <$  pKeyword "END"
                          <*  pPunctuator "{"
                          <*> pCompStmt
                          <*  pPunctuator "}"
                          <*> pStmtWModif
      <|> sem_Stmt_Expr   <$> pExpr
                          <*> pStmtWModif

-- StmtWithModifier
pStmtWModif  =  sem_StmtWithModifier_If           <$  pKeyword "if"    
                                                  <*> pExpr            
                                                  <*> pStmtWModif      
            <|> sem_StmtWithModifier_Unless       <$  pKeyword "unless"
                                                  <*> pExpr            
                                                  <*> pStmtWModif      
            <|> sem_StmtWithModifier_While        <$  pKeyword "while" 
                                                  <*> pExpr            
                                                  <*> pStmtWModif      
            <|> sem_StmtWithModifier_Until        <$  pKeyword "until" 
                                                  <*> pExpr            
                                                  <*> pStmtWModif      
            <|> sem_StmtWithModifier_Rescue       <$  pKeyword "rescue"
                                                  <*> pExpr            
                                                  <*> pStmtWModif
            <|> pSucceed sem_StmtWithModifier_Nil

-- UndefParams
pUndefParams = pFoldrSep_ng (sem_UndefParams_Cons, sem_UndefParams_Cons) (pPunctuator ",") pUndefParam

-- UndefParam
pUndefParam  =  sem_UndefParam_Identifier <$> --TODO
            <|> sem_UndefParam_Constant   <$>
            <|> sem_UndefParam_Function   <$>
            <|> sem_UndefParam_Symbol     <$>
            <|> sem_UndefParam_KwAsMethod <$>
            <|> sem_UndefParam_OpAsMethod <$>

-- AliasStmt
pAliasStmt  =  sem_AliasStmt_Global     <$> pTGlobalIdent 
                                        <*> pTGlobalIdent
           <|> sem_AliasStmt_UndefParam <$> pUndefParam
                                        <*> pUndefParam



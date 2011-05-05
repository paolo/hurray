module ParseToken where

import Lexer
import Token
import UU.Parsing

instance Eq Lexeme where
  (Lexeme _ TLiteralInt    _        ) == (Lexeme _ TLiteralInt    _        ) = True
  (Lexeme _ TLocalIdent    _        ) == (Lexeme _ TLocalIdent    _        ) = True
  (Lexeme _ TConstantIdent _        ) == (Lexeme _ TConstantIdent _        ) = True
  (Lexeme _ TLiteralStr    _        ) == (Lexeme _ TLiteralStr    _        ) = True
  (Lexeme _ TEOF           _        ) == (Lexeme _ TEOF           _        ) = True
  (Lexeme _ TEOL           _        ) == (Lexeme _ TEOL           _        ) = True
  (Lexeme _ t1             (Just s1)) == (Lexeme _ t2             (Just s2)) = t1 == t2 && s1 == s2
  _                                   == _                                   = False

instance Ord Lexeme where
  compare x y | x==y      = EQ
              | x<=y      = LT
              | otherwise = GT
  (Lexeme _ tok1 str1) <= (Lexeme _ tok2 str2)
      = tok1 < tok2 || (tok1 == tok2 && str1 <= str2)

instance Symbol Lexeme

getValue (Lexeme position category value) = maybe "" id value

tSym :: Token -> String -> Parser Lexeme String
tSym category string = getValue <$> pSym (Lexeme (AlexPn 0 0 0) category (Just string))

pID, pCID, pCadena, pEOF, pBool :: Parser Lexeme String
pID              =  tSym TLocalIdent    ""
pCID             =  tSym TConstantIdent ""
pCadena          =  tSym TLiteralStr    ""
pEOF             =  tSym TEOF           ""
pEOL             =  tSym TEOL           ""
pBool	         =  pPalRes "true" <|> pPalRes "false"

pEntero :: Parser Lexeme Int
pEntero          = (\x -> (read x) :: Int) <$> tSym TLiteralInt  ""

pPalRes :: String -> Parser Lexeme String
pPalRes       pc =                             tSym TKeyword     pc

pSeparador sep = tSym cat sep
  where cat = maybe TLBrack id (sep `lookup` separador)

pOperador sep = tSym cat sep
  where cat = maybe TPlus   id (sep `lookup` operador)

separador = [ ("["  , TLBrack   )
            , ("]"  , TRBrack   )
            , ("("  , TLParen   )
            , (")"  , TRParen   )
            , ("{"  , TLBrace   )
            , ("}"  , TRBrace   )
            , ("::" , TColon2   )
            , (","  , TComma    )
            , (";"  , TSemiColon)
            , ("."  , TDot      )
            , (".." , TDot2     )
            , ("...", TDot3     )
            , ("?"  , TQuestion )
            , (":"  , TColon    )
            , ("=>" , TAssoc    )
            ]

operador = [ ("+"  , TPlus     )
           , ("-"  , TMinus    )
           , ("*"  , TTimes    )
           , ("/"  , TDiv      )
           , ("%"  , TMod      )
           , ("**" , TPow      )
           , ("==" , TEQ       )
           , ("!=" , TNEQ      )
           , (">"  , TGT       )
           , (">=" , TGEQ      )
           , ("<"  , TLT       )
           , ("<=" , TLEQ      )
           , ("<=>", TCMP      )
           , ("===", TEQQ      )
           , ("="  , TAsignment)
           , ("^"  , TCaret    )
           , ("&"  , TAndBit   )
           , ("|"  , TOrBit    )
           , ("<<" , TLShift   )
           , (">>" , TRShift   )
           , ("&&" , TAndOp    )
           , ("||" , TOrOp     )
           , ("!"  , TNotRaw   )
           , ("~"  , TNyoro    )
           , ("!~" , TNMatch   )
           , ("=~" , TMatch    )
           ]

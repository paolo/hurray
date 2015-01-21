module TokenParser where

import Lexer
import Token
import UU.Parsing

instance Eq Lexeme where
  (Lexeme _ TGlobalIdent   _        ) == (Lexeme _ TGlobalIdent   _        ) = True
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

pId, pCId, pString, pEOF, pEOL, pBool :: Parser Lexeme String
pId              =  tSym TLocalIdent    ""
pCId             =  tSym TConstantIdent ""
pString          =  tSym TLiteralStr    ""
pEOF             =  tSym TEOF           ""
pEOL             =  tSym TEOL           ""
pBool	         =  pKeyword "true" <|> pKeyword "false"

pInteger :: Parser Lexeme Int
pInteger = (\x -> (read x) :: Int) <$> tSym TLiteralInt  ""

pKeyword :: String -> Parser Lexeme String
pKeyword pc = tSym TKeyword pc

pPunctuator :: String -> Parser Lexeme String
pPunctuator p = tSym TPunctuator p

pOperator :: String -> Parser Lexeme String
pOperator op = tSym TOperator op

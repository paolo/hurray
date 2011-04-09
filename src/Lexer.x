-- 
-- Lexical Syntax for Ruby.
--
{
module Lexer where

import Data.Maybe
import Control.Monad

import Token
}

%wrapper "monad"

$endl          = [\n]
$white         = [\t\ \r]
$num1          = [1-9]
$num           = [0-9]
$alpha         = [a-zA-Z]
$alphanum      = [$num $alpha]
$identif_char  = [$alphanum _]
$identif_start = [$alpha _]
$source_char   = [$printable $white $endl]

-- Comments
@lineComment     = \#.*
@blockCommentBeg = \=begin(\ .*)?
@blockCommentEnd = \=end(\ .*)?

-- Identifiers
@local_identif     = ([a-z]|_)($alphanum|_)*
@global_identif    = \$ $identif_start $identif_char*
@class_identif     = \@\@ $identif_start $identif_char*
@instance_identif  = \@ $identif_start $identif_char*
@cons_identif      = [A-Z] $identif_char*
@meth_only_identif = (@cons_identif | @local_identif)(! | \?)
@meth_only_assign  = (@cons_identif | @local_identif) \=

-- Numeric Literals
@decimal_int_lit = 0 | ($num1 (_? $num)*)

-- String Literals
-- sq: single quoted
$sq_escaped_char     = [\'\\]
$sq_non_escaped_char = $source_char # $sq_escaped_char
@sq_escaped_seq      = \\ ($sq_non_escaped_char | $sq_escaped_char)
@sq_string           = ($sq_non_escaped_char | @sq_escaped_seq)*
-- dq: double quoted
$dq_escaped_char     = [\\ntrfvaebs]
$dq_non_escaped_char = $source_char # [$dq_escaped_char $endl] 
@dq_escaped_seq      = \\ [$dq_escaped_char $dq_non_escaped_char \n]
@dq_string           = (($source_char # [\" \| \\]) | @dq_escaped_seq)*

-- Keywords
ruby :-
<0> BEGIN        { mkl TKeyword }
<0> END          { mkl TKeyword }
<0> __ENCODING__ { mkl TKeyword }
<0> __END__      { mkl TKeyword }
<0> __FILE__     { mkl TKeyword }
<0> __LINE__     { mkl TKeyword }
<0> alias        { mkl TKeyword }
<0> and          { mkl TKeyword }
<0> begin        { mkl TKeyword }
<0> break        { mkl TKeyword }
<0> case         { mkl TKeyword }
<0> class        { mkl TKeyword }
<0> def          { mkl TKeyword }
<0> defined\?    { mkl TKeyword }
<0> do           { mkl TKeyword }
<0> else         { mkl TKeyword }
<0> elsif        { mkl TKeyword }
<0> end          { mkl TKeyword }
<0> ensure       { mkl TKeyword }
<0> false        { mkl TKeyword }
<0> for          { mkl TKeyword }
<0> if           { mkl TKeyword }
<0> in           { mkl TKeyword }
<0> module       { mkl TKeyword }
<0> next         { mkl TKeyword }
<0> nil          { mkl TKeyword }
<0> not          { mkl TKeyword }
<0> or           { mkl TKeyword }
<0> redo         { mkl TKeyword }
<0> rescue       { mkl TKeyword }
<0> retry        { mkl TKeyword }
<0> return       { mkl TKeyword }
<0> self         { mkl TKeyword }
<0> super        { mkl TKeyword }
<0> then         { mkl TKeyword }
<0> true         { mkl TKeyword }
<0> undef        { mkl TKeyword }
<0> unless       { mkl TKeyword }
<0> until        { mkl TKeyword }
<0> when         { mkl TKeyword }
<0> while        { mkl TKeyword }
<0> yield        { mkl TKeyword }

-- Comments
<0>             @lineComment      { skip                                  }
<0>             @blockCommentBeg  { beginComment `andBegin` comment_state }
<comment_state> @blockCommentEnd  { endComment `andBegin` initial_state   }
<comment_state> $endl             { skip                                  }
<comment_state> .*                { skip                                  }

-- Identifiers
<0> @local_identif      { mkl TLocalIdent     }
<0> @global_identif     { mkl TGlobalIdent    }
<0> @class_identif      { mkl TClassIdent     }
<0> @instance_identif   { mkl TInstanceIdent  }
<0> @cons_identif       { mkl TConstantIdent  }
<0> @meth_only_identif  { mkl TMethodIdent    }
<0> @meth_only_assign   { mkl TMethodIdent    }

-- Punctuators
<0> \[      { mkl TLBrack    }
<0> \]      { mkl TRBrack    }
<0> \(      { mkl TLParen    }
<0> \)      { mkl TRParen    }
<0> \{      { mkl TLBrace    }
<0> \}      { mkl TRBrace    }
<0> ::      { mkl TColon2    }
<0> \,      { mkl TComma     }
<0> \;      { mkl TSemiColon }
<0> \.      { mkl TDot       }
<0> \.\.    { mkl TDot2      }
<0> \.\.\.  { mkl TDot3      }
<0> \?      { mkl TQuestion  }
<0> :       { mkl TColon     }
<0> \=\>    { mkl TAssoc     }

-- Operators
<0> \+      { mkl TPlus      }
<0> \-      { mkl TMinus     }
<0> \*      { mkl TTimes     }
<0> \/      { mkl TDiv       }
<0> \%      { mkl TMod       }
<0> \*\*    { mkl TPow       }
<0> \=\=    { mkl TEQ        }
<0> \!\=    { mkl TNEQ       }
<0> \>      { mkl TGT        }
<0> \>\=    { mkl TGEQ       }
<0> \<      { mkl TLT        }
<0> \<\=    { mkl TLEQ       }
<0> \<\=\>  { mkl TCMP       }
<0> \=\=\=  { mkl TEQQ       }
<0> \=      { mkl TAsignment }
<0> \^      { mkl TCaret     }
<0> \&      { mkl TAndBit    }
<0> \|      { mkl TOrBit     }
<0> \<\<    { mkl TLShift    }
<0> \>\>    { mkl TRShift    }
<0> \&\&    { mkl TAndOp     }
<0> \|\|    { mkl TOrOp      }
<0> \!      { mkl TNotRaw    }
<0> \~      { mkl TNyoro     }
<0> \!\~    { mkl TNMatch    }
<0> \=\~    { mkl TMatch     }

-- Numeric Literals
<0> @decimal_int_lit { mkl TLiteralInt }

-- String Literals
<0>               \'          { (mkl TBeginStr) `andBegin` sq_string_state }
<sq_string_state> @sq_string  { mkl TLiteralStr                            }
<sq_string_state> \'          { (mkl TEndStr) `andBegin` initial_state     }
<0>               \"          { (mkl TBeginStr) `andBegin` dq_string_state }
<dq_string_state> @dq_string  { mkl TLiteralStr                            }
<dq_string_state> \"          { (mkl TEndStr) `andBegin` initial_state     }

<0> $white+      { skip }
<0> $endl        { mkl TEOL }

{
-- States
initial_state :: Int
initial_state = 0

-- Lexeme type
data Lexeme = Lexeme AlexPosn Token (Maybe String)

instance Show Lexeme where
  show (Lexeme _ TEOF _)  = "  Lexeme TEOF"
  show (Lexeme p tok mst) = "  Lexeme Tok: " ++ show tok ++ " at " ++ showPosn p ++ showmst mst
    where
      showmst Nothing  = ""
      showmst (Just s) = " string: " ++ show s

mkl :: Token -> AlexInput -> Int -> Alex Lexeme
mkl tok (p, _, str) len = return (Lexeme p tok (Just (take len str)))

-- Utilities
showPosn :: AlexPosn -> String
showPosn (AlexPn _ row col) = show row ++ ":" ++ show col

tokPosn :: Lexeme -> AlexPosn
tokPosn (Lexeme p _ _) = p

alexEOF = return (Lexeme (AlexPn eofPosition eofRowPosition eofColPosition) TEOF Nothing)

eofPosition    = -1
eofRowPosition = -1
eofColPosition = -1

lexerError :: String -> Alex a
lexerError msg = 
  do (pos, c, input) <- alexGetInput
     let imp1 = filter (/= '\r') (takeWhile (/= '\n') input)
     let imp2 = if length imp1 > 30
                   then trim (take 30 imp1)
                   else trim imp1
     let disp = if null input
                   then " at end of file."
                   else if null imp2
                           then " before end of line"
                           else " on char: " ++ show c ++ " before: '" ++ show imp2 ++ "'"
     let disp2 = if null msg
                    then "Lexer error"
                    else trim msg
     alexError (disp2 ++ " at " ++ showPosn pos ++ disp)
  where
    trim = reverse . dropWhile (== ' ') . reverse . dropWhile (== ' ')

-- getLexerStringState :: Alex Bool
-- getLexerStringState = Alex $ (\s @AlexState{alex_ust=ust} -> Right (s, lexerStringState ust))

-- getLexerCommentDepth :: Alex Int
-- getLexerCommentDepth = Alex $ (\s @AlexState{alex_ust=ust} -> Right (s, lexerCommentDepth ust))


-- Alex Actions
beginComment :: AlexInput -> Int -> Alex Lexeme
beginComment inp@(_, c, _) len = 
  if c /= '\n'
    then lexerError (show c ++ "Bad comment block initialization")
    else skip inp len

endComment :: AlexInput -> Int -> Alex Lexeme
endComment inp@(_, c, _) len =
  if c /= '\n'
    then lexerError "Bac comment block ending"
    else skip inp len

-- Execution
scanner :: String -> Either String [Lexeme]
scanner str = let loop = do (t, m) <- complementError alexMonadScan
                            when (isJust m) (lexerError (fromJust m))
                            let lexeme@(Lexeme _ tok _) = t
                            if tok == TEOF
                              then do return [lexeme]
                              else do toks <- loop
                                      return (lexeme : toks)
              in runAlex str loop

complementError :: Alex a -> Alex (a, Maybe String)
complementError (Alex a1) = Alex (\s -> case a1 s of
                                             Right (s', x) -> Right (s', (x, Nothing))
                                             Left  message -> Right (s, (undefined, Just message)))

pretty :: String -> IO ()
pretty str = 
  case (scanner str) of
    Left  s    -> putStr $ show s
    Right list -> putStr $ showln list
      where 
        showln []     = ""
        showln (x:xs) = (show x) ++ "\n" ++ showln xs

}

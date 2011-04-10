module Main where

import Lexer
import Parser
import System (getArgs)

main = 
  do args <- getArgs
     text <- readFile $ head args
     let tokens = runScanner text
     print "Scanner output\n"
     print tokens
     print "\nParser output\n"
     ast <- parser tokens
     ast

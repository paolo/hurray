module Main where

import Lexer
import Parser
import System (getArgs)

main = 
  do --args <- getArgs
     text <- readFile "../test/helloworld/helloworld.rb" -- $ head args
     let tokens = runScanner text
     print (show "Scanner output\n")
     print tokens
     print "\nParser output\n"
     ast <- parser tokens
     ast

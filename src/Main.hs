module Main where

import Lexer
import Parser

main = do str <- readFile "../test/helloworld/helloworld.rb"
          let tokens = runScanner str -- "print (3 + 4)\n"
--          print tokens
          ast <- parser tokens
          ast

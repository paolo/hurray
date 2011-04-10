module Main where

import Token
import Lexer
import System (getArgs)

main = 
  do
    args <- getArgs
    text <- readFile $ head args
    pretty text
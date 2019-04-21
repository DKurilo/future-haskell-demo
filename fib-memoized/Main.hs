{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Prelude.Unicode
import Control.Monad.Unicode
import Control.Monad
import System.IO
import System.Environment

fib ∷ Int → Integer
fib = ([fib' n | n ← [0..]] !!)
    where fib' 0 = 0
          fib' 1 = 1
          fib' n = fib (n-2) + fib (n-1)

main ∷ IO ()
main = show ∘ fib ∘ read ∘ head <$> getArgs ≫= putStrLn


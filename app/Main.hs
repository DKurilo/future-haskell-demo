{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad
import System.Environment
import System.IO
import System.Directory
import qualified Data.ByteString.Char8 as BSC
import Debug.Trace
import Text.AhoCorasick
import Data.Map (Map, fromList, (!), keys)

fixFile :: StateMachine Char String -> Map String String -> String -> String -> String -> IO ()
fixFile sm rm din dout n = doesFileExist fn >>= \p -> when p go
    where fn = din ++ ('/':n)
          go = readFile fn >>= writeFile (dout ++ ('/':n)) . fixString sm rm

fixString :: StateMachine Char String -> Map String String -> String -> String
fixString _ _ "" = ""
fixString sm rm cs
    | null ps = cs
    | otherwise = bcs ++ rm ! v ++ ['/' | (not . null $ acs) && head acs /= '"'] ++
                  fixString sm rm acs
    where ps = findAll sm cs
          i = minimum . map pIndex $ ps
          ps' = filter (\p' -> pIndex p' == i) $ ps
          l = maximum . map pLength $ ps'
          p = head . filter (\p' -> pLength p' == l) $ ps'
          bcs = take (pIndex p) cs
          acs = drop (pIndex p + pLength p) cs
          v = pVal p

process :: StateMachine Char String -> Map String String -> String -> String -> IO ()
process sm rm din dout = listDirectory din >>= mapM_ (fixFile sm rm din dout)

main :: IO ()
main = do
    (fr:din:dout:_) <- getArgs
    rm <- fromList . map ((\(f:t:_) -> (BSC.unpack f,BSC.unpack t)) . BSC.split '\t') .
         filter (/="") . BSC.split '\n' <$> BSC.readFile fr
    let sm = makeSimpleStateMachine . keys $ rm
    process sm rm din dout


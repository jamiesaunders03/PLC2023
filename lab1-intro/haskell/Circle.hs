{-# OPTIONS_GHC -fno-warn-type-defaults  -fno-warn-missing-signatures #-}
module Main where

import System.Environment (getArgs)

main =
  do
  args <- getArgs
  case args of 
    [size] -> drawCirc (read size)
    _ -> error $ "Missing argument"

drawCirc :: Integer -> IO ()
drawCirc 0 = putStr ""
drawCirc size = do 
  sequence_ (map putStrLn (circleLines size))
  putStrLn ""
  drawCirc newSize
  where
    newSize = (quot (size * 3) 4)

circleLines :: Integer -> [String]
circleLines size =
  map (circleLine size) [1..size]

circleLine :: Integer -> Integer -> String
circleLine size i =
  map (circleChar size i) [1..(size*2)]

circleChar :: Integer -> Integer -> Integer -> Char
circleChar size i jj =
  if shouldPaint then '*' else ' '
  where
  shouldPaint =
    shouldPaintS size
  shouldPaintS s =
    abs (i^2 + j^2 - s^2) < s
    where
    j = div jj 2

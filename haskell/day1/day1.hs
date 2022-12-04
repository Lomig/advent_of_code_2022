module Main where

import Data.List (sort)

main :: IO ()
main =
  readFile "input.txt"
    >>= return . solve . lines
    >>= print

  >>
  readFile "input.txt"
    >>= return . solve2 . lines
    >>= print


------------------------------------------------------------------------------------
-- Solutions
------------------------------------------------------------------------------------

solve :: [String] -> Int
solve = solve' (maximum) [0]

solve2 :: [String] -> Int
solve2 = solve' (sumThreeMax) [0]



solve' :: ([Int] -> Int) -> [Int] -> [String] -> Int
solve' (reducer) calories@(x:xs) inputLines = case inputLines of
  []      -> reducer calories
  ("":ys) -> solve' (reducer) (0:calories) ys
  [y]     -> solve' (reducer) (newCount:xs) [] where newCount = x + read y :: Int
  (y:ys)  -> solve' (reducer) (newCount:xs) ys where newCount = x + read y :: Int


------------------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------------------

sumThreeMax :: [Int] -> Int
sumThreeMax = sumFirstThree . reverse . sort

sumFirstThree :: [Int] -> Int
sumFirstThree list = case list of
  []        -> 0
  [x]       -> x
  (x:y:[])  -> x + y
  (x:y:z:_) -> x + y + z
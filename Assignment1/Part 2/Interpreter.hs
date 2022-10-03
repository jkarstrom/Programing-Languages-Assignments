module Interpreter where

import AbsNumbers

eval :: Exp -> Integer
eval (Num n) = n
eval (Plus n m) = (eval n) + (eval m)
eval (Minus n m) = (eval n) - (eval m)
eval (Times n m) = (eval n) * (eval m)
eval (Divide n m) = (eval n) `div` (eval m)
eval (UMinus n) = - (eval n)
eval (Mod n m) = (eval n) `mod` (eval m)
eval (Power n m) = (eval n) ^ (eval m)
eval (Max n m) | (eval n) > (eval m) = (eval n) | (eval n) < (eval m) = (eval m)
eval (Min n m) | (eval n) > (eval m) = (eval m) | (eval n) < (eval m) = (eval n)
eval (Abs n) = abs (eval n)

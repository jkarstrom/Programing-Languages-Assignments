module Interpreter where

import AbsLambdaNat
import ErrM
import PrintLambdaNat

execCBN :: Program -> [Exp]
execCBN (Prog []) = []
execCBN (Prog (e:es)) = (evalCBN e):(execCBN (Prog es))

evalCBN :: Exp -> Exp
evalCBN (EApp e1 e2) = case (evalCBN e1) of
    (EAbs i e3) -> evalCBN (subst i e2 e3)
    e3 -> EApp e3 e2
evalCBN (EIf e1 e2 e3 e4) = if (evalCBN e1) == (evalCBN e2) then evalCBN e3 else evalCBN e4
evalCBN (ELet i e1 e2) = evalCBN (EApp (EAbs i e2) e1) 
evalCBN (ERec i e1 e2) = evalCBN (EApp (EAbs i e2) (EFix (EAbs i e1)))
evalCBN (EFix e) = evalCBN (EApp e (EFix e)) 
-- evalCBN ENil 
-- evalCBN (ECons e1 e2) 
-- evalCBN (EHd e) 
-- evalCBN (ETl e) 
-- evalCBN (ELE e1 e2)
evalCBN (EPlus e1 e2) = case (evalCBN e1) of
    (EInt n) -> case (evalCBN e2) of
        (EInt m) -> EInt (n+m)
        e2' -> EPlus (EInt n) e2'
    e1' -> case (evalCBN e2) of 
        (EInt m) -> EPlus e1' (EInt m)
        e2' -> EPlus e1' e2'
evalCBN (EMinus e1 e2) = case (evalCBN e1) of
    (EInt n) -> case (evalCBN e2) of
        (EInt m) -> EInt (n-m)
        e2' -> EMinus (EInt n) e2'
    e1' -> case (evalCBN e2) of 
        (EInt m) -> EMinus e1' (EInt m)
        e2' -> EMinus e1' e2'
evalCBN (ETimes e1 e2) = case (evalCBN e1) of
    (EInt n) -> case (evalCBN e2) of
        (EInt m) -> EInt (n*m)
        e2' -> ETimes (EInt n) e2'
    e1' -> case (evalCBN e2) of 
        (EInt m) -> ETimes e1' (EInt m)
        e2' -> ETimes e1' e2'
evalCBN (EInt n) = EInt n
evalCBN x = x 

-- a quick and dirty way of getting fresh names, rather inefficient for big terms...
fresh_aux :: Exp -> String
fresh_aux (EVar (Id i)) = i ++ "0"
fresh_aux (EApp e1 e2) = fresh_aux e1 ++ fresh_aux e2
fresh_aux (EAbs (Id i) e) = i ++ fresh_aux e
fresh_aux _ = "0"

fresh = Id . fresh_aux -- for Id see AbsLamdaNat.hs

-- beta reduction (capture avoiding substitution)
subst :: Id -> Exp -> Exp -> Exp
subst id s (EVar id') | id == id' = s
                      | otherwise = EVar id'
subst id s (EApp e1 e2) = EApp (subst id s e1) (subst id s e2)
subst id s e@(EAbs id' e') = 
    let f = fresh e 
        e'' = subst id' (EVar f) e' in 
        EAbs f $ subst id s e''
---
subst id s (EIf e1 e2 e3 e4) = EIf (subst id s e1) (subst id s e2) (subst id s e3) (subst id s e4)
subst id s (ELet i e1 e2) = subst id s (EApp (EAbs i e2) e1)
subst id s (ERec i e1 e2) = subst id s (EApp (EAbs i e2) (EFix (EAbs i e1)))
subst id s (EFix e) = EFix (subst id s e)
subst id s (EInt n) = EInt n
subst id s (EPlus e l) = EPlus (subst id s e) (subst id s l)
subst id s (EMinus e l) = EMinus (subst id s e) (subst id s l)
subst id s (ETimes e l) = ETimes (subst id s e) (subst id s l)
-- add the missing cases


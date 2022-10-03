-- A Virtual Machine (VM) for Arithmetic (template)

-----------------------
-- Data types of the VM
-----------------------

-- Natural numbers
data NN = O | S NN
  deriving (Eq,Show) -- for equality and printing

-- Integers
data II = II NN NN
  deriving (Eq,Show) -- for equality and printing

-- Positive integers (to avoid dividing by 0)
data PP = I | T PP
  deriving (Eq, Show)

-- Rational numbers
data QQ =  QQ II PP
  deriving (Eq,Show)

------------------------
-- Arithmetic on the  VM
------------------------
-- addI :: II -> II -> II
-- addI (II a b) (II c d) = II addN(a c) addN(b d)

-- multI :: II -> II -> II
-- multI (II a b) (II a b) = II addN(multN(a c) multN(b d)) addN(multN(a d) multN(b c))

-- subtrI :: II -> II -> II
-- subtrI(II a b) (II c d) = II addN(a d) addN(b c)

-- negI :: II -> II
-- negI(II a b) = II b a

----------------
-- NN Arithmetic
----------------

-- add natural numbers
addN :: NN -> NN -> NN
addN O m = m
addN (S n) m = S (addN n m)

-- multiply natural numbers
multN :: NN -> NN -> NN
multN O m = O
multN (S n) m = addN (multN n m) m

----------------
-- II Arithmetic
----------------

-- Addition: (a-b)+(c-d)=(a+c)-(b+d)
addI :: II -> II -> II
addI (II a b) (II c d) = II (addN a c) (addN b d)

-- Multiplication: (a-b)*(c-d)=(ac+bd)-(ad+bc)
multI :: II -> II -> II
multI (II a b) (II c d) = II (addN (multN a c) (multN b d)) (addN (multN a d) (multN b c))

-- Subtraction:
subtrI :: II -> II -> II
subtrI (II a b) (II c d) = II (addN a d) (addN b c)

-- Negation
negI :: II -> II
negI (II a b) = II b a

----------------
-- QQ Arithmetic
----------------
--AddP Implementation

addP :: PP -> PP -> PP
addP I m = (T m)
addP (T n) m = T (addP n m)

-- multiply positive numbers
multP :: PP -> PP -> PP
multP I m = m
multP m (T(n)) = addP (multP m n) m

-- convert numbers of type PP to numbers of type NN
nn_pp :: PP -> NN
nn_pp I = S O
nn_pp (T m) = S (nn_pp m)

--convert numbers of type PP to numbers of type II
ii_pp :: PP -> II
ii_pp I = II (S O) (O)
ii_pp (T m) = II (S (nn_pp m)) O

-- Addition: (a/b)+(c/d)=(ad+bc)/(bd)
addQ :: QQ -> QQ -> QQ
addQ(QQ a b) (QQ c d) = QQ (addI(multI(a)(ii_pp(d))) (multI(ii_pp(b))(c))) (multP(b)(d))

-- Multiplication: (a/b)*(c/d)=(ac)/(bd)
multQ :: QQ -> QQ -> QQ
multQ (QQ a b) (QQ c d) = QQ (multI a c) (multP b d)

----------------
-- Normalisation
----------------
normalizeI :: II -> II
--II (S(S(O))) (SO) should be (S(O))
--essentially if then to get rid of S's
normalizeI(II O O) = II O O
normalizeI(II O n) = (II O n)
normalizeI(II m O) = (II m O)
normalizeI(II (S(m)) (S(n))) = normalizeI(II m n)

----------------------------------------------------
-- Converting between VM-numbers and Haskell-numbers
----------------------------------------------------

-- Precondition: Inputs are non-negative
nn_int :: Integer -> NN
nn_int 0 = O
nn_int n = S (nn_int (n-1))

int_nn :: NN->Integer
int_nn O = 0
int_nn (S n) = 1 + int_nn n

ii_int :: Integer -> II
ii_int 0 = II (O) (O)
ii_int n = II (nn_int(n)) (O)

int_ii :: II -> Integer
int_ii (II (O) (O)) = 0
int_ii (II (n) (m)) = int_nn(n) - int_nn(m)

-- Precondition: Inputs are positive
pp_int :: Integer -> PP
pp_int 1 = I
pp_int n = T(pp_int(n-1))

int_pp :: PP->Integer
int_pp I = 1
int_pp (T n) = 1 + int_pp n

float_qq :: QQ -> Float
float_qq (QQ n m) = fromInteger(int_ii(n)) / fromInteger(int_pp(m))

----------
-- Testing
----------
main = do
--  print $ addN (S (S O)) (S O)
--  print $ multN (S (S O)) (S (S (S O)))
--  print $ addP (T (T I)) (I)
--  print $ multP (T (T I)) (T (T (T I)))
--  print $ addI (II (S O) O) (II (S (S O)) O)
--  print $ multI (II (S (S O)) (S O)) (II (S (S (S O))) (S (S O)))
--  print $ subtrI (II (S (S O)) (S O)) (II (S (S O)) (S(S O)))
--  print $ negI (II (S (S (S O))) (S (S O)))
--  print $ ii_pp (T I)
--  print $ nn_int (2)
--  print $ int_nn (S (S O))
--  print $ pp_int (3)
--  print $ int_pp (T(T I))
--  print $ addQ (QQ (II (S O) (O)) (T I)) (QQ (II (S (S O)) (O)) (T I))
--  print $ multQ (QQ (II (S O) (O)) (T I)) (QQ (II (S O) (O)) (T I))
--  print $ ii_int (4)
--  print $ int_ii (II (S (S O)) (S O))

# The Memory Model

We will look at the memory model. The memory is divided in an inmutable stack [^immutable-stack] and a mutable heap. To see the difference, run

    λ val a = new [] ;;

which creates a new variable `a` on the stack and a new memory cell (address) on the heap. To see this run

    λ :env

upon which we get to see a full list of the stack (called `Env` below for environment) and the heap (called `Memory` below). I only show part of the overall output.

    Env:
    "a" -> <address 0>
    Memory:
    0 -> Nothing
    
This tells us that the value of `a` is `address 0` and that the memory at address `0` has not been initialised.

    λ a:=3;;
    λ :env
    "a" -> <address 0>
    0 -> Just 3

This tells us that now address `a` stores 3.

We can also create variables that are not addresses but just integers (or booleans or functions) as in

    λ val b = 5;;     
    λ :env
    "a" -> <address 0>
    "b" -> 5
    0 -> Just 3

**Exercise:** Predict what happens after ...

    λ b:=a;;
    λ :env

... and then run the above and inspect the environment.

On the other hand, the following works as expected:

    λ a:=b;;
    λ :env
    "a" -> <address 0>
    "b" -> 5
    0 -> Just 5

Now address `a`, which is `0`, stores 5.

What may be unexpected is the following.

    λ val c = new [];;     
    λ c:= 7;;
    λ a:= c;;
    λ :env

Pause for a moment ...

... and fill in what you should think replace the ??? in 

    "a" -> <address 0>
    0 -> Just ???

In fact, we get

    "a" -> <address 0>
    "b" -> 5
    "c" -> <address 1>
    0 -> Just <address 1>
    1 -> Just 7

The address `a` now stores the address `c`, which stores `7`.

On the other hand, 

    λ a:= !c;;
    λ :env

gives us

    "a" -> <address 0>
    "b" -> 5
    "c" -> <address 1>
    0 -> Just 7
    1 -> Just 7


**Remark:** The names `a` and `b` and `c` are on the stack. Their values did not change through the examples. On the other hand, the addresses themselves are on the heap and their values were changed using assignment `:=`.

**Summary:** We encountered three new functions, which we can think of as having types as indicated:

    new :: () -> addr
    (:=) :: addr -> value -> ()
    ! :: addr -> value

`new` takes an environment and allocates a new address on the heap. `:=` is an infix operator that takes an address and a value and changes the environment by assigning the value to the address. `!` takes an address and returns its value.

**Exercise:** Run through the following, at each step predicting the result and then inspecting the environment.

    λ a := [1,"NULL"];;
    λ :env
    λ val b = new [];;
    λ b := [2,a];;
    λ :env
    λ a := [3,b];;
    λ :env
    
Explain, by inspecting the environment, in which sense the above defines a cyclic list.

[^immutable-stack]: The stack is mutable at the top level. This can be seen by 

        λ val i = 0;;
        λ i;;
        λ val i = i+1;;
        λ i;;

    but this does not work insdide a function.
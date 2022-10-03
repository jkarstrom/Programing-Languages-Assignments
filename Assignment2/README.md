# Date of Submission 11/10/2021

# What we learned
We wrote and built a simple programing language off of lambda calculus with limited functions. Starting from lambdaNat0 to lambdaNat5 we slowly expanded the amount of functions that it was able to use. We learned how to generate and make a parser then using the compiled interpreter to test the grammar we created.
I gained an appreciation for already built programming languages in the fact that there is a surplus of coding that you have to establish just to do simple things such as addition for a single type.
Got a lot of strong practice in deciphering errors through an understanding of string rewriting.
## What is completed and where we had problems
The assignment is complete as far as we could make it, we are caught up on testing and running into an infinite loop and not sure where to go from here.
We ran into issues with some formatting and parenthesis in our .lc file as well as some problems with definitions in ELE.
We might have a problem in our subst formulas.

## Task 2 Questions:
### Sum function
In the sum function the output for sum x:2:3:4:# would be x+9 (x+2+3+4) and the output for sum 1:2:3:x:# would be 1+(2+(3+x)). Our language is essentially string rewriting at this point, it has no way to reduce x apart from just knowing its an x, so it just takes what it does know and evaluates what it can. Because it works by taking the first term then taking the rest of the terms in the sum function, when we have the x at the beginning it looks perfectly normal in x+9 but that is because its evaluating x + (2+(3+4)). However, when we put the x further down the line, like the second example, it can't evaluate (3+x) so it can't evaluate (2+(3+x)) and so on.
### Plus 2 function
If someone would replace the 2 with y, it would obviously not be a +2 function anymore. When we ran this on our haskell version, it gave us an error message and would not run. I believe this is because it is an undefined variable and you can't add an undefined variable. we do however have the symbol for 'x' defined in our evalCBN.
In the Lambda Version, it runs just fine and says that for example, term 1 would be 1 + y. I understand this to be because our language doesn't have any way to define the y so it just is essentially string rewriting. It's okay with just saying 'thing' + 'thing' because it has no reason to believe it's wrong, it just doesn't have anything to do with it so it leaves it as it is. That's how it is defined in our EvalCBN
## Known Problems
Right now we are running into a problem when running our stack exec that is resulting in an infinite loop. As of right now I don't know if it is a problem with our code or a problem with our test file. We are relatively sure that it shouldn't be a big fix to find the solution to this problem because of our communication with professor and working together as well as discussion with peers whose code does work is in line.

UPDATE:: The problems were in the subst functions for the infinite loop. Fixing this allowed us to test our .lc file. Most of the issues there were semantic problems. Specifically, forgetting to add the 
## Testing
### To test our code in the Haskell portion of this assignment, we first made a parser and built it, compiled an interpreter using the interpreter.hs and stack build, and then we ran commands on the command line.
We also tested the .lc files in the test folder using the stack exec commands, which resulted in the infinite loop. 

UPDATE :: We no longer get the infinite loop and were able to test every branch of each function in the .lc file. More notes on testing and cases are in the .lc file themselves.

# Assignment and Theory
## Differences between Haskell and LambdaNat5. What we should expand upon on LambdaNat5
When you are coding in your own language in LambdaNat5, your definitions are purely based on what you’ve defined. This has the benefit of if you have any problems, you can reference the entirety of the language simply because you designed it. That being said, you essentially have to design EVERYTHING. I think this is helpful for succinct projects and specificity, but it could get convoluted for bigger projects.

With Haskell, you’re going to have predefined functionality that you don’t have to design yourself. While this requires you to learn the functionality of Haskell, you have the benefit of having more resources on the internet and a larger selection of knowledge.

We have the functionality to do some operations but it definitely doesn’t feel like a functional programming language, especially since we are restricted to an Integer as the only common type.

If we wanted to extend LambdaNat5 to have the functionality of Haskell, we would essentially need to program and beef up the amount of functions. We’d need to expand the operators, get more specific with Booleans, define more types, etc. Then, in defining these types, you’d have to redefine and adapt the code for the functionality you already have(IE adding doubles and integers, do we allow it? What do we assume?)

# Reflect on the differences between LambdaNat5 and the Calculator. In LambdaNat5, why can't we implement arithmetic using the simple "evalCBN (EPlus e1 e2) = (evalCBN e1) + (evalCBN e2)"
This is more than just a simple calculator program, we now have lists with multiple numbers and many different cases that we have to take account for. Its written in the questions "simple" its too simple of a function and doesnt consider the multiple numbers in a list, which numbers in the list, what if the list is empty, what if the list isnt sorted. The more we expand on a language, the more cases we have to write and think of the possible what ifs.
The reason this doesn't work is because our plus function is defined for integers. the expressions e1 and e2 could be lists or ENil's but we only have the ability to define it for integers right now so that is what we do. However, with this format we can also expand the functionality for different types, if we eventually wanted to give it functionality for strings or lists.

## Thoughts on Lambda
### Joan -
I think using the lambda language that we built was very interesting and satisfying. I am used to using Haskell since it is what we have been using for this course but seeing the difference syntactically between solutions.ls and solutions.hs having the same logic but written out in different ways. We have been building up throughout this assignment the language different functions and now applying them to the same type of logic of Haskell was very impressive. In haskell we used Arithmetic to start defineing our lambda language. For example "let x = e1 in e2" can be translated to ""(\ x . e2 ) e1" in lambda. As we expanded our language and started adding more functions. I am used to coding languages that dont use words as constructors so it’s very different using a written language that is a lot more different than java. Makes me take for granted a lot of things that are built into programing languages and now before working on major projects I will look at the pros and cons of languages and the limitations that they have.


### Matthew - 
I think theoretically the concept of lambda calculus works and makes sense, but I am not familiar enough with the syntax at this point for it to feel comfortable to code with it or to be confident in the substitutions with complex rules outside of basic arithmetic such as if/thens. 
I think I forget that the way this is coded is essentially just string rewriting given set rules. This is actually a really helpful concept, however, I just lack familarity with it so it's got the growing pains that coding in OO or even Haskell doesn't have as much of.
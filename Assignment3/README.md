# Date of Submission 11/10/2021
# Joan Karstrom and Matthew

# What we learned
Learned about editing circular lists, and circular lists as a data structure as implemented in Haskell.
Learned to rewrite code from one custom language to another with Haskell.
As this is last assignment, we also learned in the way that the assignments were created, how to manage workloads and utilize github with Visual Studio Code.
## What is completed and where we had problems
Part 1 was good practice in rewriting code from one custom language to another. I had some syntax problems in translation but those were easily fixable. 
Part 2 was a was a bit difficult using circular lists and building the functions around that while using the new grammar. We expanded our functions on lambdafun with newCList, next, get, update, insert and delete.

## Questions:
### What would happen if we insert/delete on the element before rather than after?
We are using circular lists in this assignment, we are not able to do it on the element. One of the main things that cycle lists does is that it collects tasks to work on them one by one hence our file being called round robin.

## Known Problems
There are no known problems with the program. Both parts of the assignment parse correctly and work.

## Testing
### How to test
You would first build the Lambda Fun program by preforming a "stack exec" in the lambdafun folder and then running "stack build" to launch the program. From there you can use the command line to test your own question using the the program's functions.

To test pt.1 of our assignment you would type ":load test/examples.lc " in the lambdafun program

To test pt.2 of our assignment you would type ":load test/round-robin.lc" in the lambdafun program

# Assignment and Theory
## Thoughts
### Joan -
Throughout this assignment, we learned to write examples as we did in assignment two in our lambdafun program. It was really rewarding using the terminal program when our tests worked as it was formatted very well.

### Matthew -
Custom languages in Haskell are difficult to comprehend at first but very handy in the fact that you have the entire library of functions available to you. It is similar to picking up any new language each time at a smaller scale. At this point, I'm not sure how I will utilize Haskell except as a learning tool, but it is another good compsci tool to have in my belt.
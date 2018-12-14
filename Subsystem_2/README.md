Subsystem 2: Catapult Efficiency Optimisation
=======

*Minimise energy required to raise the arm by varying mechanical parameters of the catapult arm*

Main Scripts 
-------
*Four algorithms are available: SQP, GA, Pattern Search and Interior Point.*

**MATLAB scripts should be run:**

SQP.m

GA.m

PS.m

IP.m

**Notes:**
SQP is the most effective algorithm and Genetic Algorithm is the least. Occasionally, when an infeasible point (NaN, Inf or complex) is encountered, GA.m will come up with an error. When this happens, run the script several times until it works. This is due to the stochastic nature of GA.

Visualisation Script
-------
*Visualisation of shape of objective function and some constraints*

Graph.m

Execution time
-------
The execution time is approximately 0.2 - 6 seconds depending on algorithm. GA will usually take the longest.

Processor used: Core i7-4710MQ

OS: Windows 7 Professional


Dependencies
-------
The script requires only MATLAB_R2018b

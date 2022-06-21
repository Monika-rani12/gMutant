# gMutant
A gCov based Mutation Testing Analyser
In this section, we present a walkthrough of the actual demonstration on our proposed analyser, gMutant. For this demo, let us consider the same sample program explained in the Working Example section. The main components in our framework are Test Case generator, Mutant Generator, Instrumentation Component, gCov Profiler, and  Analyzer.

**Test Case Generator:** As already mentioned, the CBMC and AFL test case generators are used in our implementation in order to generate test cases. 

_AFL Test Case Generation:_ AFL takes the mcdc_program as an input, compiles it and then executes using the below “afl-fuzz” command. Here, the timeout is set to 900 seconds i.e., 15 mins for generating good number of test cases.

afl-gcc -fno-stack-protector -z execstack mcdc_program.c -o mcdc_program
timeout 900 afl-fuzz -i ./testcase-Random/ -o output_directory ./compiled_mcdcprogram

_CBMC Test Case Generation:_ The following CBMC’s command generates the test cases based on MC/DC coverage criterion for the mcdc_program.c program.

./cbmc --cover mcdc “mcdc_program.c”

**Mutant Generator:** Before generating the mutants, the Covered Lines information is extracted by executing the test cases (CBMC/AFL-generated) on the mcdc_program.c program. Below is the command. The below screenshots highlight commands used to compile (gcc)  and execute (gcov).

****

Next, mutator.py program is called which performs the PNF, CNF, ROR, LOR and AOR mutant operations on the program and generates mutants. These Reachable Mutants are generated for the predicates located at the Covered Lines. The following are the code snippets of mutator.py program.


**Instrumentation Component:** This component instruments the mcdc_program.c program with the generated Reachable Mutants. The following code snippets highlight the instrumentation part, where a mutated predicate is compared to the original predicate using “!=” operator, and wrapped in a if statement. The if statement prints the line number when its condition holds. All the mutants are instrumented in the same manner, and the if statements are placed above the corresponding predicate. The same is done for all the predicates of the program to produce a Mutant Meta program. 

**gCov Profiler:** gCov executes the test cases (CBMC/AFL-generated) on the generated Mutant Meta program and gives a report. The report contains the line numbers of the killed mutants. The same is highlighted in the below screenshot.
**Analyzer:** This component takes the generated gCov report and the Reachable Mutants as inputs and generates the Mutation Score (%). The below code snippet highlights the analyzer code.

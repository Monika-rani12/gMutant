# gMutant
A gCov based Mutation Testing Analyser

The main components in our framework are Test Case generator, Mutant Generator, Instrumentation Component, gCov Profiler, and  Analyzer.

**Test Case Generator:** As already mentioned, the CBMC and AFL test case generators are used in our implementation in order to generate test cases. 

_AFL Test Case Generation:_ AFL takes the mcdc_program as an input, compiles it and then executes using the below “afl-fuzz” command. Here, the timeout is set to 900 seconds i.e., 15 mins for generating good number of test cases.

**afl-gcc -fno-stack-protector -z execstack mcdc_program.c -o mcdc_program**
**timeout 900 afl-fuzz -i ./testcase-Random/ -o output_directory ./compiled_mcdcprogram**

_CBMC Test Case Generation:_ The following CBMC’s command generates the test cases based on MC/DC coverage criterion for the mcdc_program.c program.

**./cbmc --cover mcdc “mcdc_program.c”**

**Mutant Generator:** Before generating the mutants, the Covered Lines information is extracted by executing the test cases (CBMC/AFL-generated) on the mcdc_program.c program. Below is the command. Next, mutator.py program is called which performs the PNF, CNF, ROR, LOR and AOR mutant operations on the program and generates mutants. These Reachable Mutants are generated for the predicates located at the Covered Lines. 

**Instrumentation Component:** This component instruments the mcdc_program.c program with the generated Reachable Mutants.

**gCov Profiler:** gCov executes the test cases (CBMC/AFL-generated) on the generated Mutant Meta program and gives a report. The report contains the line numbers of the killed mutants. The same is highlighted in the below screenshot.

**Analyzer:** This component takes the generated gCov report and the Reachable Mutants as inputs and generates the Mutation Score (%). The below code snippet highlights the analyzer code.

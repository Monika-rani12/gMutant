echo monika
#!/bin/ksh
export BENCHMARK=$1
export MODE=$2
gcc -fprofile-arcs -ftest-coverage -g ${BENCHMARK}.c
if [ $MODE == 2 ]
then
TC_PATH=$BENCHMARK-TC
else
TC_PATH=cleaned-TCs
fi
for q in `ls -v ../$TC_PATH/*`;
do
./a.out < $q
done
gcov -abcfu ${BENCHMARK}.c > Cov_report-${BENCHMARK}.txt
rm a.out
#The below code is to run tests on Original Program
./deadmutants.sh $BENCHMARK
#Need to add command for test case generator 
python mutator.py $BENCHMARK.c $BENCHMARK-Mutants-$MODE
cp $BENCHMARK-Mutants-$MODE/MetaWithBraces-V4.c ../CBMC
mv $BENCHMARK-Mutants-$MODE/MetaWithBraces-V4.c $BENCHMARK-Mutants-$MODE/
mv Cov_report-${BENCHMARK}.txt $BENCHMARK-Mutants-$MODE/
mv CoveredLines.txt $BENCHMARK-Mutants-$MODE/
mv ${BENCHMARK}.* $BENCHMARK-Mutants-$MODE/




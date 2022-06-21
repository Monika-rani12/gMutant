export BENCHMARK=$1
export VERSION=$2
export BOUND=$3

mkdir $BENCHMARK-RESULTS
cp Programs/GCOV/$BENCHMARK.c SequenceGenerator/
cp Programs/GCOV/$BENCHMARK.c MutationAnalysis/
cp Programs/GCOV/$BENCHMARK.c afl-2.52b/
cp Programs/CBMC/$BENCHMARK.c CBMC/
############################################### AFL Test case generation ###########################################################
Xres1=$(date +%s.%N)
let dtX=0

cd afl-2.52b
./runafl.sh $BENCHMARK
mv results-afl-$BENCHMARK/cleaned-TCs ../
mv results-afl-$BENCHMARK ../
rm $BENCHMARK*
cd ../

Xres2=$(date +%s.%N)
dtX=$(echo "$Xres2 - $Xres1" | bc)
ddX=$(echo "$dtX/86400" | bc)
dtX2=$(echo "$dtX-86400*$ddX" | bc)
dhX=$(echo "$dtX2/3600" | bc)
dtX3=$(echo "$dtX2-3600*$dhX" | bc)
dmX=$(echo "$dtX3/60" | bc)
dsX=$(echo "$dtX3-60*$dmX" | bc)
echo "***Total AFL Test case generation time in seconds" $dtX >>  Time-$BENCHMARK.txt
printf "Total AFL Test case generation time: %d:%02d:%02d:%02.4f\n" $ddX $dhX $dmX $dsX >>  Time-$BENCHMARK.txt
echo "****************AFL Test case generation time Report - End**************************" >>  Time-$BENCHMARK.txt
############################################### CBMC TC generation ###########################################################
Xres1=$(date +%s.%N)
dtX=0
cd CBMC
./mcdc-cbmc.sh $BENCHMARK $VERSION $BOUND
cd ..

Xres2=$(date +%s.%N)
dtX=$(echo "$Xres2 - $Xres1" | bc)
ddX=$(echo "$dtX/86400" | bc)
dtX2=$(echo "$dtX-86400*$ddX" | bc)
dhX=$(echo "$dtX2/3600" | bc)
dtX3=$(echo "$dtX2-3600*$dhX" | bc)
dmX=$(echo "$dtX3/60" | bc)
dsX=$(echo "$dtX3-60*$dmX" | bc)
echo "***Total CBMC TC generation time in seconds" $dtX >>  Time-$BENCHMARK.txt
printf "Total CBMC TC generation time: %d:%02d:%02d:%02.4f\n" $ddX $dhX $dmX $dsX >>  Time-$BENCHMARK.txt
echo "****************CBMC TC generation time Report - End**************************" >>  Time-$BENCHMARK.txt
############################################### MCDC Meta Program generation ###########################################################
Xres1=$(date +%s.%N)
dtX=0

cd MutationAnalysis
./MA_SC_MCC_V2.sh $BENCHMARK 1
cd ..


Xres2=$(date +%s.%N)
dtX=$(echo "$Xres2 - $Xres1" | bc)
ddX=$(echo "$dtX/86400" | bc)
dtX2=$(echo "$dtX-86400*$ddX" | bc)
dhX=$(echo "$dtX2/3600" | bc)
dtX3=$(echo "$dtX2-3600*$dhX" | bc)
dmX=$(echo "$dtX3/60" | bc)
dsX=$(echo "$dtX3-60*$dmX" | bc)
echo "***Total Mutant Meta Program generation time in seconds" $dtX >>  Time-$BENCHMARK.txt
printf "Total Mutant Meta Program generation time: %d:%02d:%02d:%02.4f\n" $ddX $dhX $dmX $dsX >>  Time-$BENCHMARK.txt
echo "****************Mutant Meta Program generation time Report - End**************************" >>  Time-$BENCHMARK.txt
############################################### gMutant - AFL - MCDC ###########################################################

cd CBMC
Ares1=$(date +%s.%N)
let dtA=0

gcc -fprofile-arcs -ftest-coverage -g MetaWithBraces-V$VERSION.c

for q in `ls -v ../cleaned-TCs/*`;
do
./a.out < $q >> temp1.txt
done
grep "KILLED" temp1.txt > temp2.txt
sort -u temp2.txt > final_result-gMCDC-AFL.txt
rm a.out
feasible=$(grep "KILLED" final_result-gMCDC-AFL.txt | wc -l)
total_seq=$(grep "KILLED" MetaWithBraces-V$VERSION.c | wc -l)
echo "***Total no. of Killed Mutants = " $feasible >> $BENCHMARK-gMCDC-AFL-score-report
echo "***Total no. of Mutants = " $total_seq >> $BENCHMARK-gMCDC-AFL-score-report
((score = (${feasible} * 100) / ${total_seq}))
echo "***Mutation Score = " $score >> $BENCHMARK-gMCDC-AFL-score-report

Ares2=$(date +%s.%N)
dtA=$(echo "$Ares2 - $Ares1" | bc)
ddA=$(echo "$dtA/86400" | bc)
dtA2=$(echo "$dtA-86400*$ddA" | bc)
dhA=$(echo "$dtA2/3600" | bc)
dtA3=$(echo "$dtA2-3600*$dhA" | bc)
dmA=$(echo "$dtA3/60" | bc)
dsA=$(echo "$dtA3-60*$dmA" | bc)
echo "***Total AFL gMutant runtime in seconds" $dtA >> ../Time-$BENCHMARK.txt
printf "Total AFL gMutant runtime: %d:%02d:%02d:%02.4f\n" $ddA $dhA $dmA $dsA >> ../Time-$BENCHMARK.txt
echo "****************AFL gMutant time Report - End**************************" >>  ../Time-$BENCHMARK.txt
cd ..
############################################### MCDC Meta Program generation ###########################################################
Xres1=$(date +%s.%N)
dtX=0
cp Programs/GCOV/$BENCHMARK.c MutationAnalysis/
cd MutationAnalysis
./MA_SC_MCC_V2.sh $BENCHMARK 2
cd ..


Xres2=$(date +%s.%N)
dtX=$(echo "$Xres2 - $Xres1" | bc)
ddX=$(echo "$dtX/86400" | bc)
dtX2=$(echo "$dtX-86400*$ddX" | bc)
dhX=$(echo "$dtX2/3600" | bc)
dtX3=$(echo "$dtX2-3600*$dhX" | bc)
dmX=$(echo "$dtX3/60" | bc)
dsX=$(echo "$dtX3-60*$dmX" | bc)
echo "***Total Mutant Meta Program generation time in seconds" $dtX >>  Time-$BENCHMARK.txt
printf "Total Mutant Meta Program generation time: %d:%02d:%02d:%02.4f\n" $ddX $dhX $dmX $dsX >>  Time-$BENCHMARK.txt
echo "****************Mutant Meta Program generation time Report - End**************************" >>  Time-$BENCHMARK.txt
############################################### gMutant - CBMC - MCDC###########################################################
Ares1=$(date +%s.%N)
dtA=0
cd CBMC
gcc -fprofile-arcs -ftest-coverage -g MetaWithBraces-V$VERSION.c

for q in `ls -v ../$BENCHMARK-TC/*`;
do
./a.out < $q >> temp1.txt
done
grep "KILLED" temp1.txt > temp2.txt
sort -u temp2.txt > final_result-gMCDC-CBMC.txt
rm a.out
feasible=$(grep "KILLED" final_result-gMCDC-CBMC.txt | wc -l)
total_seq=$(grep "KILLED" MetaWithBraces-V$VERSION.c | wc -l)
echo "***Total no. of Killed Mutants = " $feasible >>  $BENCHMARK-gMCDC-CBMC-score-report.txt
echo "***Total no. of Mutants = " $total_seq >>  $BENCHMARK-gMCDC-CBMC-score-report.txt
((score = (${feasible} * 100) / ${total_seq}))
echo "***Mutation Score = " $score >> $BENCHMARK-gMCDC-CBMC-score-report.txt

Ares2=$(date +%s.%N)
dtA=$(echo "$Ares2 - $Ares1" | bc)
ddA=$(echo "$dtA/86400" | bc)
dtA2=$(echo "$dtA-86400*$ddA" | bc)
dhA=$(echo "$dtA2/3600" | bc)
dtA3=$(echo "$dtA2-3600*$dhA" | bc)
dmA=$(echo "$dtA3/60" | bc)
dsA=$(echo "$dtA3-60*$dmA" | bc)
echo "***Total CBMC gMutant  runtime in seconds" $dtA >> ../Time-$BENCHMARK.txt
printf "Total CBMC gMutant  runtime: %d:%02d:%02d:%02.4f\n" $ddA $dhA $dmA $dsA >> ../Time-$BENCHMARK.txt
echo "****************CBMC gMutant  time Report - End**************************" >>  ../Time-$BENCHMARK.txt
cd ..
#################################################### Directory cleaning #########################################################

#mkdir $BENCHMARK-RESULTS/PredicatesResults
mkdir $BENCHMARK-RESULTS/CBMC
mkdir $BENCHMARK-RESULTS/SCORE
mkdir $BENCHMARK-RESULTS/KILLED

mv MutationAnalysis/$BENCHMARK-Mutants* $BENCHMARK-RESULTS
mv cleaned-TCs $BENCHMARK-RESULTS
mv $BENCHMARK-TC $BENCHMARK-RESULTS
mv Time-$BENCHMARK.txt $BENCHMARK-RESULTS
mv $BENCHMARK-RESULTS/cleaned-TCs $BENCHMARK-RESULTS/AFL-TCs
mv $BENCHMARK-RESULTS/*TC $BENCHMARK-RESULTS/CBMC-TCs

mv CBMC/$BENCHMARK-result-MCDC-original.txt $BENCHMARK-RESULTS/CBMC
mv CBMC/$BENCHMARK-result-MCDC.txt $BENCHMARK-RESULTS/CBMC
mv CBMC/MetaWithBraces-V$VERSION.c $BENCHMARK-RESULTS/CBMC
mv CBMC/$BENCHMARK.c $BENCHMARK-RESULTS/CBMC
mv results-afl-$BENCHMARK $BENCHMARK-RESULTS
mv CBMC/$BENCHMARK-gMCDC-AFL-score-report $BENCHMARK-RESULTS/SCORE
mv CBMC/$BENCHMARK-gMCDC-CBMC-score-report.txt $BENCHMARK-RESULTS/SCORE
mv CBMC/final_result* $BENCHMARK-RESULTS/KILLED

rm CBMC/temp*.txt
rm CBMC/MetaWithBraces*

###########################################################################################################################################

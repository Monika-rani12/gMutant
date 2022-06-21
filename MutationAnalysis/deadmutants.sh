BENCHMARK=$1
sed -E -e '/-:|call|unconditional|branch|-block|#####|\$\$\$\$\$/d' $BENCHMARK.c.gcov > tmp1.txt
cut -d: -f1-2 tmp1.txt > tmp2.txt
sed 's/.*://' tmp2.txt > CoveredLines.txt
sed -r -i 's/\s+//g' CoveredLines.txt
#cp CoveredLines.txt $BENCHMARK-Mutants
rm tmp*.txt


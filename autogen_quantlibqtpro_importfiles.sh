#!/bin/sh

cat "Print cpp/hpp/c/h file list for QuantLibQt.pro file..."

cd ~/QuantLib/QuantLibQt/ql
find . -name '*.c' >> ../c.txt
find . -name '*.h' >> ../h.txt
find . -name '*.cpp' >> ../cpp.txt
find . -name '*.hpp' >> ../hpp.txt
cd ../
sort cpp.txt > cpps.txt
sort hpp.txt > hpps.txt
cat c.txt cpps.txt > ccpps.txt
cat h.txt hpps.txt > hhpps.txt
sed -e "s/^./ql/g" ccpps.txt >> qlccpps.txt
sed -e "s/^./ql/g" hhpps.txt >> qlhhpps.txt
rm cpp.txt
rm hpp.txt
rm cpps.txt
rm hpps.txt
rm c.txt
rm h.txt
rm ccpps.txt
rm hhpps.txt

cat "c/cpp/h/hpp file full name listup completed."

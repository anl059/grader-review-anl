CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf temp
git clone $1 student-submission
echo 'Finished cloning'
if [[ -f student-submission/ListExamples.java ]]
    then echo "ListExamples found"
else 
    echo "Error: ListExamples not found"
fi
mkdir temp
cp student-submission/ListExamples.java temp
cp TestListExamples.java temp
cp -r lib temp
cd temp
javac -cp $CPATH *.java 2> error.txt
if [[ $? -ne 0 ]]
    then echo "Error: Files not compiling"
    exit 1
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > error.txt
if grep -q "FAILURES!!!" error.txt
    then echo "Failed, check error.txt for more details"
else 
    echo "Passed"
fi
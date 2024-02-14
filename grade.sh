CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
then
    echo "file found!"
else 
    echo "file not found!"
fi

cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java

if [[ $? -eq 0 ]]
then
    echo "Compilation succesful"
else
    echo "Compilation non successful"
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt


if [[$(grep -q "OK")]]
then 
    echo "All tests passed!"
    exit
fi 

TOTALTESTRUN=$(grep -Eo "Tests run: [0-9]+" junit-output.txt | grep -Eo "[0-9]+")

TOTALFAIL=$(grep -Eo "Failures: [0-9]+" junit-output.txt | grep -Eo "[0-9]+")

TOTALSUCCESS=$((TOTALTESTRUN-TOTALFAIL))

echo " Your grade is $TOTALSUCCESS / $TOTALTESTRUN "

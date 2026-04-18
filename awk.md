
awk Command
awk Command
1. What is awk?
awk is a text processing and pattern scanning tool used to:

process structured text
extract columns
filter data
perform calculations
generate reports
It is commonly used with:

log files
CSV files
space-separated data
command output

2. Full Form of awk
awk is named after its creators:

Alfred Aho
Weberger (Peter Weinberger)
Kernighan (Brian Kernighan)
So the name comes from Aho, Weinberger, Kernighan.


3. Basic Syntax
awk 'pattern { action }' file

Example:

awk '{print $1}' file.txt

This prints the first column of each line.


4. How awk Works
awk processes input line by line.

For each line:

Reads the line
Splits into fields (columns)
Applies pattern
Executes action
Moves to next line
Default delimiter: space or tab


5. Important Built-in Variables
Variable

Meaning

NR

Current line number

NF

Number of fields in current line

$0

Entire line

$1

First column

$2

Second column

$NF

Last column


6. Printing Entire Line

awk '{print $0}' file.txt

This prints the entire line.


Same as:

awk '{print}' file.txt


7. Printing Specific Columns
Example file:

John 25 India

Ravi 30 USA

Anu 22 UK

Print first column
awk '{print $1}' file.txt

Output:

John

Ravi

Anu


Print multiple columns
awk '{print $1, $3}' file.txt

Output:

John India

Ravi USA

Anu UK


Print columns with custom text
awk '{print $1 " is from " $3}' file.txt


Output:

John is from India

Ravi is from USA

Anu is from UK


8. NR (Line Number)
awk '{print NR, $0}' file.txt

Output:

1 John 25 India

2 Ravi 30 USA

3 Anu 22 UK

Useful for numbering lines.


9. NF (Number of Fields)
awk '{print NF}' file.txt

Output:

3

3

3

Each line has 3 fields.


10. Print Last Column
awk '{print $NF}' file.txt

Output:

India

USA

UK

$NF always refers to the last column.


11. Filtering Rows (Conditions)
Print rows where age > 25
awk '$2 > 25 {print $1}' file.txt

Output:

Ravi


Print rows where country is USA
awk '$3 == "USA" {print $1}' file.txt

Output:

Ravi


12. Using Delimiters (CSV Files)
Default delimiter is space, but CSV files use comma.

Use -F to set delimiter.

Example CSV file:

John,25,India

Ravi,30,USA

Anu,22,UK

Print first column
awk -F "," '{print $1}' data.csv

Output:

John

Ravi

Anu


Print name and country
awk -F "," '{print $1, $3}' data.csv

Output:

John India

Ravi USA

Anu UK


13. BEGIN and END Blocks
awk supports special blocks.

BEGIN block (runs before processing)
awk 'BEGIN {print "Start"} {print $1} END {print "End"}' file.txt

Output:

Start

John

Ravi

Anu

End


14. Calculations Using awk
Example file:

Item1 100

Item2 200

Item3 150

Sum values
awk '{sum += $2} END {print sum}' file.txt

Output:

450


15. Average Calculation
awk '{sum += $2} END {print sum/NR}' file.txt

Output:

150


16. Printing with Formatting
awk '{printf "%s costs %d\n", $1, $2}' file.txt

Output:

Item1 costs 100

Item2 costs 200

Item3 costs 150

printf gives formatted output.


17. Changing Output Delimiter
Default output delimiter is space.

You can change using OFS.

awk 'BEGIN {OFS=","} {print $1, $2}' file.txt

Output:

Item1,100

Item2,200

Item3,150


18. Data Transformation Using awk
Data transformation means modifying data while processing it.
Using awk, you can:

add values
multiply values
create new columns
modify existing columns
format output
awk is often used to transform raw data into reports.

18.1 Addition Example
Input file (marks.txt):

John 80 70

Ravi 60 90

Anu 75 85

Command
awk '{print $1, $2+$3}' marks.txt

Output
John 150

Ravi 150

Anu 160


19. Useful awk One-Liners
Print first column
awk '{print $1}' file

Print last column
awk '{print $NF}' file

Print lines containing word
awk '/error/' file

Print line numbers
awk '{print NR, $0}' file

Sum a column
awk '{sum+=$2} END {print sum}' file

Count lines
awk 'END {print NR}' file


20. Best Use Cases
awk is commonly used for:

CSV processing
Log analysis
Report generation
Column extraction
Data transformation
Summation and statistics
Filtering structured text

Summary
The awk command is a powerful text-processing tool used for column extraction, filtering, calculations, and report generation. It works line by line and splits input into fields, making it especially useful for structured data such as logs and CSV files.



#!/bin/bash
# This script is used to set up  a mini version of the grep command
# Basic Functionality:
# Search for a string (case-insensitive)
# Print matching lines from a text file
# Usage: ./mygrep.sh <pattern> <file>
# Command-Line Options:
# -n → Show line numbers for each match
# -v → Invert the match (print lines that do not match)
#Combinations like -vn, -nv should work the same as using -v -n
#read Variables from the user  - option and pattern and file

show_help() {
    echo "Usage: ./mygrep.sh [OPTIONS] <pattern> <file>"
    echo ""
    echo "Search for a string in a file and print matching lines."
    echo ""
    echo "Options:"
    echo "  -n         Show line numbers for each match"
    echo "  -v         Invert the match (print lines that do not match)"
    echo "  -n -v      Combine both options (invert and show line numbers)"
    echo "  --help     Display this help message"
    echo ""
    echo "Example usage:"
    echo "  ./mygrep.sh hello testfile.txt        # Case-insensitive search for 'hello'"
    echo "  ./mygrep.sh -n hello testfile.txt    # Case-insensitive search with line numbers"
    echo "  ./mygrep.sh -v hello testfile.txt    # Invert match for 'hello'"
    echo "  ./mygrep.sh -vn hello testfile.txt   # Invert match and show line numbers"
}
# Check if the user asked for help
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi
# Check if the user asked for help
if [[ "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if the user provided at least two arguments
if [ $# -lt 2 ]; then
    echo "mygrep: Invalid number of arguments"
    echo "Usage: ./mygrep.sh [OPTIONS] <pattern> <file>"
    exit 1
fi
# Check if the user provided more than three arguments
if [ $# -gt 3 ]; then
    echo "mygrep: Invalid number of arguments"
    echo "Usage: ./mygrep.sh [OPTIONS] <pattern> <file>"
    exit 1
fi
# Check if the first argument is -n (option)
if [[ "$1" ==  -*  ]]; then
    options=$1     # -n or any  option
    pattern=$2     # The second argument is the pattern
    file=$3        # The third argument is the file
else
    options=""     # No options
    pattern=$1     # The first argument is the pattern
    file=$2        # The second argument is the file
fi


# Check if the file exists
if [ ! -f $file ]; then
  echo "mygrep: "$file"  No such file or directory"
  exit 1
fi

# Check if the file is readable
if [ ! -r $file ]; then
  echo "mygrep: "$file": Permission denied"
  exit 1
fi

# Check if the pattern is empty
if [ -z $pattern ];then
  echo "mygrep: pattern is empty"
  exit 1
fi

#check if the file empty
if [ ! -s $file ]; then
  echo "mygrep: "$file"  File is empty"
  exit 1
fi

without_option()
{
    # Check if the pattern is in the file
while IFS= read -r line
do
       if [[ "${line,,}" =~ ${pattern,,} ]]; then
         colored_line=$(echo "$line" | sed "s/${pattern}/\x1b[31m&\x1b[0m/Ig")
            echo "$colored_line"
       fi
    done < "$file"
}

with_option(){
if [[ $options == *"n"* && $options == *"v"* ]]; then
    while IFS= read -r line
    do
             ((number++))
        if [[ ! "${line,,}" =~ ${pattern,,} ]]; then
           echo "$number:$(echo "$line" | sed "s/${pattern}/\x1b[31m&\x1b[0m/Ig")"
        fi
    done < "$file"

elif [[ $options == *"n"* ]]; then
    while IFS= read -r line
    do
             ((number++))
        if [[ "${line,,}" =~ ${pattern,,} ]]; then
           echo "$number:$(echo "$line" | sed "s/${pattern}/\x1b[31m&\x1b[0m/Ig")"
        fi
    done < "$file"
elif [[ $options == *"v"* ]]; then
    while IFS= read -r line
    do
    if [[ ! "${line,,}" =~ ${pattern,,} ]]; then
        colored_line=$(echo "$line" | sed "s/${pattern}/\x1b[31m&\x1b[0m/Ig")
            echo "$colored_line"
    fi
    done < "$file"
else
    echo "mygrep: Invalid option"
    exit 1
fi
}
if [[ $options == -* ]] ; then
    with_option
else
    without_option
fi

#################################################################################
#! /bin/bash
# Purpose  : Wrapper to send a fixed time amount
# History  :
# --------------------------------------------------------
# Date           Updated By                    Comments
# ------------   ------------                  ---------------------
# 03-MAR-2020     Corey Sykes                  Created for Sandbox Environment
#################################################################################

# Writing some base directories for logging
export present_dir=`pwd`
export LOG_DIR=${present_dir}/logs

job_name="Execute_Log_Generator"

# Setting Log Files
ETLLogFile=$LOG_DIR/$job_name.log.`date +%Y%m%d%H%M%S`

# Step 2: Go ahead and take bash arguments to run the Generator script
for arg; do
    case $arg in
        '--number_of_iterations='*) number_of_iterations=${arg#*=} ;;
        '--number_of_lines='*) number_of_lines=${arg#*=} ;;
    esac
done

# Remove the current log file if it's there
if [ -f "output.log" ]; then
    rm -rf output.log
fi

# Check if the variables are valid
re='^[0-9]+$'
if ! [[ $number_of_iterations =~ $re ]]; then
    echo "Number of Iterations is not a number. Exiting the process." >> $ETLLogFile
    exit 1
fi

if ! [[ $number_of_lines =~ $re ]]; then
    echo "Number of Lines is not a number. Exiting the process." >> $ETLLogFile
    exit 1
fi

# Go ahead and execute the iteration and generate the logs
while [[ ${number_of_iterations} -gt 0 ]]
do
    python 100_Log_Generator.py -n ${number_of_lines} -o LOG -df yes >> $ETLLogFile 2>&1
    echo "Generating logs at a 3 second interval." >> $ETLLogFile
    number_of_iterations=$(( ${number_of_iterations} - 1 ))
    sleep 10
done

# Check the exit status of the runs. If there's an issue, exit 1, otherwise success 
lvStatus=$?
if [ $lvStatus -ne 0 ]
then
    echo "====================================================" >> $ETLLogFile
    echo "ERROR: executing $job_name - " >> $ETLLogFile
    echo "$job_name Errored Out" >> $ETLLogFile
    exit 1
else
    endDate=$(date +"%s")
    diff=$(($endDate-$startDate))
    echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed." >> $ETLLogFile
    echo "-----------END: ETL COMPLETED process for " $job_name `date` "-------------" >> $ETLLogFile
    rm -f $ETLTrigger 
fi

exit 0
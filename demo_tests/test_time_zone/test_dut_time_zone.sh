#!/bin/sh
###############################################################################
#Copyright (c) 2019-2020, Mentor Graphics, a Siemens business
#
# DESCRIPTION :
#
# Verify the time zone 
# If time zone is UTC test is a pass else its a fail 
#
# Initiated By :
#      Shivaschandra K L <Shivaschandra_KL@mentor.com>
#
# Maintained By:
#	
#		Shivaschandra K L <Shivaschandra_KL@mentor.com>
###############################################################################



#Importing LAVA libraries
. ../lib/sh-test-lib

#Create output directory to log results.
OUTPUT="$(pwd)/output"
RESULT_FILE="${OUTPUT}/result.txt"
export RESULT_FILE
create_out_dir "${OUTPUT}"
cd "${OUTPUT}" || exit 1

info_msg "Running Demo Test case to verify time zone in DUT"

#Check if test running in root.
! check_root && error_msg "Please run this script as root."

test_time_zone()
{
	#output=$(date  | sed 's/.* //')
	#output=$(date | awk '{print $NF}')
	output=$(date)
	test_seq="UTC"
	echo $output
	if $(echo "$output" | grep -q "$test_seq") ;
	then
		report_pass "Time zone set on DUT is UTC:"
	else
		report_fail "Time zone set on DUT is not UTC:"
	fi
	actual_server_string=$(sntp  time.windows.com)
    info_msg "Read back from time.windows.com : $actual_server_string"
    server_time_string=$(sntp  time.windows.com | grep -o "[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}")
    info_msg "Server time captured from time.windows.com  :   $server_time_string"

    actual_system_string=$(date)
    info_msg "Read back system time : $actual_system_string"
    system_time_string=$(date | grep -o "[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}")
    info_msg "System Time :  $system_time_string"
    if $(echo "$system_time_string" | grep -q "$server_time_string") ;
    then
        report_pass "Compare DUT time and time.windows.com :"
    else
        report_fail "Compare DUT time and time.windows.com :"
    fi
}
test_time_zone

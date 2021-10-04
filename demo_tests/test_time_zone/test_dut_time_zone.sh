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




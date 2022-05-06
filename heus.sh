#!/bin/bash

# hhsd-aup-download.sh
# Script Description:
# ~
# This script uses httrack 
# to download the contents 
# of a website and all files
# in the links, instead of
# just saving the website.

# Variables:
# mirror site
website="$1"
# save location for mirror
location="$2"
# mirror depth
depth="$3"

# Functions:
# help function for -h or incorrect use of script
function help_func {
  echo "`basename "$0"`		Help Command		`basename "$0"` 

Name
	`basename "$0"` - an easy use script for httrack
	
Synopsis
	`basename "$0"` [-h] [url] [directory] [depth]
	
Description
	An easy script for httrack
	
EXAMPLES
       `basename "$0"` www.someweb.com/bob/ ~/Downloads 4
               mirror site www.someweb.com/bob/ with the download directory
               to the home folder with a mirror depth of 4

       `basename "$0"` -f www.someweb.com/bob/ ~/Downloads 4
               mirror site www.someweb.com/bob/ with the download directory 
               to the home folder with a mirror depth of 4 and overwrites 
               the files in the download directory

OPTIONS
	General options:
		-h	displays this description

COPYRIGHT
	Copyright (C) 2022  Gabriel Morales

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along
	with this program; if not, write to the Free Software Foundation, Inc.,
	51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
	
	httrack:
		Copyright (C) 1998-2017 Xavier Roche and other contributors

		This program is free software: you can redistribute it and/or 
		modify it under the terms of the GNU General Public License 
		as published by the Free Software Foundation, either version 
		3 of the License, or (at your option) any later version.

		This  program  is  distributed in the hope that it will be 
		useful, but WITHOUT ANY WARRANTY; without even the implied 
		warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
		PURPOSE.  See the GNU General Public License for more details.

		You  should have received a copy of the GNU General Public 
		License along with this program. If not, see 
		<http://www.gnu.org/licenses/>.

AVAILABILITY
	The most recent and updated version of the script can be found at: 
	https://github.com/moral-g/hhsd-aup

	httrack:
		The  most  recent released version of httrack can be found 
		at: http://www.httrack.com

AUTHOR
	Gabriel Morales <moralg640@gmail.com>

	httrack:
		Xavier Roche <roche@httrack.com>

SEE ALSO
	The script history is hosted at and part of this project: 
	https://github.com/moral-g/hhsd-aup

	httrack:
		The HTML documentation available online  at  :
		http://www.httrack.com/html/ contains
		more  detailed  information.  Please also 
		refer to the httrack FAQ available online at:
		http://www.httrack.com/html/faq.html 
		
	Process:
		written on my ipad :)" >&2
  exit 1
}

# checks if all required arguments satisfied
function check_all_arg_sat_func {
	if [ -z "$website" ] 2> /dev/null || [ -z "$location" ] 2> /dev/null || [ -z "$depth" ] 2> /dev/null; then
	      echo -e "Invalid use of the script: not all required arguments passed"
	      echo -e "Usage: `basename "$0"` -h"
	      exit 1
	fi
}

# checks if website arg is websites, folder is folder ... etc
function check_args_use_func {
	ping "$website" -qc 1 > /dev/null || error_func "ping $website"
	! [ -d "$location" ] && mkdir $location
	echo -e "Directory made: $location"
}

# error function catch
function error_func {
	echo -e "* Error at: $1\nUnsucessful run!"
	exit 1
}

# checks flags
while getopts "fh" opt; do
		case $opt in
		h) help_func >&2;;
		esac
done
# check if all arguments used
check_all_arg_sat_func
check_args_use_func
echo -e "From: $website\nDownloading mirror of depth $depth to: $location\n"
httrack $website -O "$location" -%v -r$depth || error_func "httrack $website -O "$location" -%v -r$depth"



# httrack https://www.hatboro-horsham.org/Page/716  -O "/home/moralg/websites/hhsd-aup"  -%v -r3  

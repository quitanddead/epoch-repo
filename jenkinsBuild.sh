#!/bin/bash
# jenkinsBuild.sh

# curlIt function - to be called recursively until success
curlIt ()
{
	theFile=$1;
	lowerDir=$(echo $theFile | sed 's,/var/lib/jenkins/jobs/epoch-repo/workspace/,,g');

	if [[ $2 -ne 1 ]]; then
		# First attempt with this file
		echo "Transferring $theFile";
		echo "Lower directory structure: $lowerDir";
		curl --retry 10 --ftp-create-dirs -u AiE:aie12345 -T $theFile ftp://198.27.80.126:8821/198.27.80.126_2362/$lowerDir;

		if [ $? -ne 0 ]; then
			# Error detected on transferring $theFile, set flag 1 to show retry
			curlIt $theFile 1;
		fi
	fi

	if [[ $2 -eq 1 ]]; then
		echo "Retrying $theFile";
		curl --retry 10 --ftp-create-dirs -u AiE:aie12345 -T $theFile ftp://198.27.80.126:8821/198.27.80.126_2362/$lowerDir;

		if [[ $? -ne 0 ]]; then
			# Error detected on transferring $theFile, set flag 1 to show retry
			curlIt $theFile 1;
		fi
	fi
}

# Main function
#for file in $(find /var/lib/jenkins/jobs/epoch-repo/workspace/ -type f -mmin -10 ! -path "*/.git/*" ! -name ".git*"); do
for file in $(cd /var/lib/jenkins/jobs/epoch-repo/workspace && git show --pretty="format:" --name-only | grep "."); do
	# For all files in the epoch-repo that are not part of git, call curlIt with the full path of the file
	#curlIt $file;
	echo $file;
done;

#!/bin/bash
# jenkinsBuild.sh

for file in $(find /var/lib/jenkins/jobs/epoch-repo/workspace/ -mmin -10 ! -path "*/.git/*" ! -name ".git*"); do

	#if [ -d $file ]; then
	#	lowerDir=$(echo $file | sed 's,/var/lib/jenkins/jobs/epoch-repo/workspace/,,g')
	#	curl --ftp-create-dirs -u AiE:aie12345 -T $file ftp://198.27.80.126:8821/198.27.80.126_2362/$lowerDir;
	#fi

	if [ -f $file ]; then
		lowerDir=$(echo $file | sed 's,/var/lib/jenkins/jobs/epoch-repo/workspace/,,g');
		curl --retry 10 --ftp-create-dirs -u AiE:aie12345 -T $file ftp://198.27.80.126:8821/198.27.80.126_2362/;
	fi

done

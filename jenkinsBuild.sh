#!/bin/bash
# jenkinsBuild.sh

for file in $(find /var/lib/jenkins/jobs/Epoch/workspace -mmin -10 ! -path "*/.git/*" ! -name ".git*"); do
	curl -u AiE:aie12345 -T $file ftp://198.27.80.126:8821/198.27.80.126_2362/;
done

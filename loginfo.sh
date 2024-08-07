#!/usr/bin/env bash
<< comm
IBM Copy Right 2024
Author: Andrew Lee
Description: Scans the s3 bucket and counts files uploaded.
comm
sc_store=(10002 10024 10032)
for store in ${sc_store[@]}
do
    cd /home/andrew/work/temp/techlabs/slim_chick/store.$store
    s=$(find .  -type f -name cmsservice.log | wc -l)
    yesterday=$(date -v-1d +%F)
    flac=$(aws s3 ls s3://aidt-chat-logs-sc/aidt_logs/v1/prod/$yesterday/store.$store   --recursive | grep -iEc session.flac)
    mqtt=$(aws s3 ls s3://aidt-chat-logs-sc/aidt_logs/v1/prod/$yesterday/store.$store   --recursive | grep -iEc mqtt*)
    printf "Store %s:\n" "$store"
    printf "\tCMS %d\n" "$s"
    printf "\tSession flac %d\n" "$flac"
    printf "\tMqtt jsonl %d\n" "$mqtt"
    printf "\n"
done
cd /home/andrew/work/temp/techlabs/slim_chick
echo "CMS errors":
grep -Eihr "error" | cut -d" " -f4- | sort | uniq -c |
awk '{if ($1 >20 && length($2) > 1) print $0 }' | sort -k1nr

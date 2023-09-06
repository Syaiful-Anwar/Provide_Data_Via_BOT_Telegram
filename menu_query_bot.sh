#!/bin/bash

cd /home/extradm/script
dir=/home/extradm/script

token=6281616364:AAEIrUBFOUaAQyL8hgmht0bo_0KN638F3Dk
api=https://api.telegram.org/bot6281616364:AAEIrUBFOUaAQyL8hgmht0bo_0KN638F3Dk
cat temp | grep file_id | awk -F ':' '{print $2}' | sed 's/"//g' > file_id.txt

##the file id nya
the_file_id=`cat file_id.txt`
curl -s ${api}/getFile?file_id=${the_file_id} | tail -1 | awk -v RS="," '{print}' > file_path.txt

##the file path nya
file_path=`cat file_path.txt | grep file_path | awk -F ':.' '{print $2}' | sed 's/"}}//g'`

### get File nya
curl -s https://api.telegram.org/file/bot${token}/${file_path} > /home/extradm/script/query.sql

function exe(){
        mysql -hlocalhost -uroot -pBadrun@100101! -e"$1"
}

query=`cat /home/extradm/script/query.sql`

exe "$query" |sed 's/\t/\|/g' > ${dir}/tes.txt

curl -s -X POST "${api}/sendDocument" -F chat_id="-941934550" -F document=@"${dir}/tes.txt" -F caption="Result Query"

rm ${dir}/tes.txt
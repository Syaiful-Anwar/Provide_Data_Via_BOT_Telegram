while true
do

cd /home/extradm/script

api=https://api.telegram.org/bot6281616364:AAEIrUBFOUaAQyL8hgmht0bo_0KN638F3Dk
curl -s ${api}/getUpdates | tail -1 | awk -v RS="," '{print}' > temp
update_id=`curl -s ${api}/getUpdates | awk -v RS="," '{print}' | grep update_id | awk -F "\":" '{print $2}' | grep -v update_id | tail -1`

new_id=`cat temp | grep message_id | awk -F ":" '{print $3}'`
old_id=`cat id_old`
id_tele=`cat temp | grep id | grep chat | awk -F ":" '{print $3}'`
user_id=`cat temp | grep from | awk -F":" '{print$3}'`
user_tele=`cat temp | grep username | awk -F "\"" '{print $4}' | sort -u`
msid=`cat temp | grep message_id | awk -F ":" '{print $3}'`

curl -s ${api}/getUpdates?offset=${update_id}

if [ "${new_id}" == "${old_id}" ] ; then
        echo "same"
else
menu_menu=`cat temp | grep text | awk -F "\"" '{print $4}' | awk -F "@" '{print $1}'`
date=`cat temp | grep text | awk '{print $2}' | sed -s 's/"//g'`
caption=`cat temp | grep "caption" | awk -F ":" '{print $2}' | sed 's/"//g' | head -1`
no=`cat temp | grep text | awk -F "\"" '{print $4}' | awk -F "@" '{print $1}' | awk -F " " '{print $2}'`

	##CEK MENU##
        if [ "${menu_menu}" == "/menu" ] && [ "${id_tele}" == "-941934550"  ]
        then
                bash menu_bot.sh
                echo "${new_id}" > id_old
	##MAIN MENU##
        elif [ "${menu_menu}" == "/myid" ] && [ "${id_tele}" == "-941934550" ]
        then
                curl -s -X POST ${api}/sendMessage -d reply_to_message_id="${msid}" -d chat_id=${id_tele} -d text="Your id is ${user_id}"
                echo "${new_id}" > id_old

	elif [ "${caption}" == "/query" ] && [ "${id_tele}" == "-941934550" ]
	then
		echo "Checking ..." > text_menu_menu
		curl -s -X POST ${api}/sendMessage -d reply_to_message_id="${msid}" -d chat_id=${id_tele} -d text="`cat text_menu_menu`"
		bash query_bot.sh
		echo "${new_id}" > id_old

        elif [[ "${id_tele}" == "-941934550" ]]
	then
                echo "Menu Tidak Tersedia" > text_menu_menu
                curl -s -X POST ${api}/sendMessage -d reply_to_message_id="${msid}" -d chat_id=${id_tele} -d text="`cat text_menu_menu`"
                echo "${new_id}" > id_old

        fi
fi

sleep 2
done
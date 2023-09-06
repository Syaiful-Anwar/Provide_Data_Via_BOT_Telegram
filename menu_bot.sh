idbot=6281616364
apikey=AAEIrUBFOUaAQyL8hgmht0bo_0KN638F3Dk
idchat=-941934550

menubot=`cat bot_menu.txt`

read -r -d '' pesan <<EOT
<b>BOT MENU</b>
<code>${menubot}</code>
<b> </b>
EOT
curl --data chat_id="$idchat" --data-urlencode "text=${pesan}" "https://api.telegram.org/bot${idbot}:${apikey}/sendMessage?parse_mode=HTML"
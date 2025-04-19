#!/bin/bash

GUILD_IDS=(
    "267735321695748096"  # owo
    "534940241002233896"  # soul
    "1350807682520711199" # valc
    "223070469148901376"  # gca
#    "478707034137559040" # colb (tag removed)
    "844285068275875890"  # cosi
    "1077258761443483708" # lgbt
    "349243932447604736"  # ios
    "247434867527122945"  # tit
    "710871326557995079"  # lol
    "476454574715174912"  # dual
    "427067963137589258"  # meow
    "294005213763993601"  # cute
    "986691543102529546"  # vil
    "547906569489350657"  # dev
    "1151156552888238183" # moco
    "543652415870730240"  # cybr
    "786437953299021844"  # soul
)

AUTH_TOKEN=""

trap "echo 'Script terminated by user'; exit" INT

echo "Starting tag rotation..."

while true; do
    for guild_id in "${GUILD_IDS[@]}"; do
        #echo "Setting server tag to: $guild_id"
        response=$(curl -s -w "\n%{http_code}" 'https://discord.com/api/v9/users/@me/clan' -X PUT \
            -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:137.0) Gecko/20100101 Firefox/137.0' \
            -H 'Accept: */*' \
            -H 'Content-Type: application/json' \
            -H "Authorization: $AUTH_TOKEN" \
            -H 'Origin: https://discord.com' \
            -H 'Referer: https://discord.com/channels/@me' \
            --data-raw "{\"identity_guild_id\":\"$guild_id\",\"identity_enabled\":true}")

        http_code=$(echo "$response" | tail -n1)
        body=$(echo "$response" | sed '$d')

        if [[ "$http_code" -ge 200 && "$http_code" -lt 300 ]]; then
            #echo "Request successful"
            :
        else
            echo "Request failed for guild $guild_id with status code $http_code:"
            echo "$body"
        fi

        #echo "Waiting 10 seconds before next request..."
        sleep 10
    done

    #echo "Completed one full cycle, starting again..."
done
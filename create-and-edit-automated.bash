#!/bin/bash

# Bouldering Event Creation Automation Script
# This script creates multiple bouldering events by reading from event-data.csv

CSV_FILE="event-data.csv"
OUTPUT_FILE="created-events.txt"
ERROR_LOG="errors.log"

PHPSESSID="your_php_session_id_here"  # Replace with actual session ID

# Clear previous output files
> "$OUTPUT_FILE"
> "$ERROR_LOG"

echo "Starting event creation process..."
echo "=================================="

# Skip header row and process each line
tail -n +2 "$CSV_FILE" | while IFS=',' read -r number date extra; do
  # Skip empty lines
  if [ -z "$number" ] || [ -z "$date" ]; then
    continue
  fi
  
  echo "Processing Event #$number for date $date..."
  
  # Step 1: Send create request
  RESPONSE=$(curl -s -i 'https://sschub.ent.cginet/event/create' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
    -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
    -H 'Cache-Control: max-age=0' \
    -H 'Connection: keep-alive' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -b "_ga=GA1.2.1899802495.1720526793; loginname=sam.molyneux; PHPSESSID=${PHPSESSID}; _gid=GA1.2.1978454783.1766503853; _ga_74WSQFHV9C=GS2.2.s1766503852$o248$g1$t1766504772$j60$l0$h0" \
    -H 'Origin: https://sschub.ent.cginet' \
    -H 'Referer: https://sschub.ent.cginet/event/create' \
    -H 'Sec-Fetch-Dest: document' \
    -H 'Sec-Fetch-Mode: navigate' \
    -H 'Sec-Fetch-Site: same-origin' \
    -H 'Sec-Fetch-User: ?1' \
    -H 'Upgrade-Insecure-Requests: 1' \
    -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36' \
    -H 'sec-ch-ua: "Google Chrome";v="143", "Chromium";v="143", "Not A(Brand";v="24"' \
    -H 'sec-ch-ua-mobile: ?1' \
    -H 'sec-ch-ua-platform: "Android"' \
    --data-raw "name=Bouldering+at+City+Bouldering%2C+Aldgate+%5B${number}%5D\
&location=City+Bouldering+Aldgate%0D%0A33+Aldgate+High+Street%2C+London%2C+EC3N+1AH%0D%0A%2810+minutes+walk+from+London+Fenchurch+Street+Office%29\
&cost=%C2%A35+for+SSC+members%3B+See+https%3A%2F%2Fwww.citybouldering.co.uk%2Fpricing+%28Pay+As+You+Go+section%29+for+guest+pricing\
&start=${date}+18%3A00%3A00\
&end=${date}+21%3A00%3A00\
&deadline=${date}+10%3A30%3A00\
&club=lon")
  
  # Check for errors in create request
  if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create event #$number" | tee -a "$ERROR_LOG"
    continue
  fi
  
  # Extract the redirect URL from Location header
  REDIRECT_URL=$(echo "$RESPONSE" | grep -i "^Location:" | sed 's/Location: //' | tr -d '\r\n')
  
  if [ -z "$REDIRECT_URL" ]; then
    echo "ERROR: No redirect URL found for event #$number" | tee -a "$ERROR_LOG"
    continue
  fi
  
  # Extract event slug from redirect URL
  EVENT_SLUG=$(echo "$REDIRECT_URL" | sed 's|.*/event/||' | sed 's|/edit||')
  
  echo "  Created event: $EVENT_SLUG"
  echo "https://sschub.ent.cginet/event/$EVENT_SLUG" >> "$OUTPUT_FILE"
  
  # Step 2: Send edit request to add detailed information
  EDIT_URL="https://sschub.ent.cginet/event/${EVENT_SLUG}/edit"
  
  EDIT_RESPONSE=$(curl -s -i "$EDIT_URL" \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundarykruAzhLsXGlEU7LB' \
  -b "_ga=GA1.2.1899802495.1720526793; loginname=sam.molyneux; PHPSESSID=${PHPSESSID}; _gid=GA1.2.1978454783.1766503853; _ga_74WSQFHV9C=GS2.2.s1766509899$o249$g1$t1766510123$j49$l0$h0" \
  -H 'Origin: https://sschub.ent.cginet' \
  -H "Referer: $EDIT_URL" \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36' \
  -H 'sec-ch-ua: "Google Chrome";v="143", "Chromium";v="143", "Not A(Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?1' \
  -H 'sec-ch-ua-platform: "Android"' \
  --data-raw $'------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="name"\r\n\r\nBouldering at City Bouldering, Aldgate ['"$number"$']\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="fileToUpload"; filename=""\r\nContent-Type: application/octet-stream\r\n\r\n\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="description"\r\n\r\n\u0021[img](http://sschub.ent.cginet/uploads/1358-63ca5ee9069ed6ec78a6f419__0014_Intro%20to%20Bouldering.jpg){.img-responsive .center-block}\r\n\r\nWeekly bouldering at City Bouldering, Aldgate. Includes entry, shoe hire, and chalk hire.\r\n\r\nThe event is suitable for all ability levels, if you\'re a beginner and would like some tips to get started let us know.\r\n\r\nFeel free to request a place after the deadline on the event (up until lunch time the day of).\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="location"\r\n\r\nCity Bouldering Aldgate\r\n33 Aldgate High Street, London, EC3N 1AH\r\n(10 minutes walk from London Fenchurch Street Office)\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="cost"\r\n\r\nFive pounds for SSC members; See https://www.citybouldering.co.uk/pricing (Pay As You Go section) for guest pricing\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="instructions"\r\n\r\nFeel free to request a place after the deadline on the event (up until lunch time the day of).\r\nThere are a few bits of admin to do beforehand, please complete them before the event:\r\n* Please ensure you pre-register at the City Bouldering website (https://www.citybouldering.co.uk/pre-register) to avoid delays. (Pay attention to the video as they will ask you a few basic safety questions when you arrive).\r\n* The SSC requires a disclaimer to be filled out in order to attend, please fill out the form with ‘Regular Event’ as the ‘Event Date’ then email to me before your first session. Available here: https://cgigbr-my.sharepoint.com/:w:/g/personal/sam_molyneux_cgi_com/EdReAPVlKo9Dh9s473DYMhwBmfbNbV8aF_vBEpM_MQ9n_Q?e=7z1dJu\r\nOtherwise, all you need to do is turn up any time after 5 30 with comfortable sports clothing and your **CGI ID** then give your name at reception. Lockers are available and require either a padlock or pound coin to use.\r\n*Please pay \u00a35 to the below bank details:\r\nLONDON SPORTS & SOCIAL CLUB CGI UK\r\nTREASURERS ACCOUNT\r\nSORT CODE: 30-98-90\r\nACCOUNT: 16111060\r\nREFERENCE: <NAME> CLIMB'"$number"$'\r\n\r\nFeel free to send any questions my way.\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="start"\r\n\r\n'"$date"$' 18:00:00\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="end"\r\n\r\n'"$date"$' 21:00:00\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="deadline"\r\n\r\n'"$date"$' 10:30:00\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="organiser"\r\n\r\n3482\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="organiser2"\r\n\r\n3146\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="club"\r\n\r\nlon\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB\r\nContent-Disposition: form-data; name="Release"\r\n\r\n\r\n------WebKitFormBoundarykruAzhLsXGlEU7LB--\r\n')

  # Check for errors in edit request
  if [ $? -ne 0 ]; then
    echo "ERROR: Failed to edit event #$number ($EVENT_SLUG)" | tee -a "$ERROR_LOG"
  else
    echo "  Successfully edited event #$number"
  fi
  
  # Add a small delay between requests to avoid overwhelming the server
  sleep 1
done

echo "=================================="
echo "Event creation complete!"
echo "Created event links saved to: $OUTPUT_FILE"
if [ -s "$ERROR_LOG" ]; then
  echo "Errors encountered - see: $ERROR_LOG"
else
  echo "No errors encountered."
fi

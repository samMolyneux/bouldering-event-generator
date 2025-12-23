# send initial create event form supplying basic details
PHPSESSID="your_php_session_id_here"  # Replace with actual session ID
curl 'https://sschub.ent.cginet/event/create' \
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
  --data-raw 'name=Bouldering+at+City+Bouldering%2C+Aldgate+%5B77%5D&location=City+Bouldering+Aldgate%0D%0A33+Aldgate+High+Street%2C+London%2C+EC3N+1AH%0D%0A%2810+minutes+walk+from+London+Fenchurch+Street+Office%29&cost=%C2%A35+for+SSC+members%3B+See+https%3A%2F%2Fwww.citybouldering.co.uk%2Fpricing+%28Pay+As+You+Go+section%29+for+guest+pricing&start=2026-01-13+18%3A00%3A00&end=2026-01-13+21%3A00%3A00&deadline=2026-01-13+10%3A30%3A00&club=lon'

# response is a 303 redirect to the edit page of the created event, now edit it with more details

curl 'https://sschub.ent.cginet/event/bouldering-at-city-b-2065/edit' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryBmNswQvNxABq8Qd7' \
  -b "_ga=GA1.2.1899802495.1720526793; loginname=sam.molyneux; PHPSESSID=${PHPSESSID}; _gid=GA1.2.1978454783.1766503853; _ga_74WSQFHV9C=GS2.2.s1766503852$o248$g1$t1766506562$j54$l0$h0" \
  -H 'Origin: https://sschub.ent.cginet' \
  -H 'Referer: https://sschub.ent.cginet/event/bouldering-at-city-b-2065/edit' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36' \
  -H 'sec-ch-ua: "Google Chrome";v="143", "Chromium";v="143", "Not A(Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?1' \
  -H 'sec-ch-ua-platform: "Android"' \
  --data-raw $'------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="name"\r\n\r\nBouldering at City Bouldering, Aldgate [02]\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="fileToUpload"; filename=""\r\nContent-Type: application/octet-stream\r\n\r\n\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="description"\r\n\r\n\u0021[img](http://sschub.ent.cginet/uploads/1358-63ca5ee9069ed6ec78a6f419__0014_Intro%20to%20Bouldering.jpg){.img-responsive .center-block}\r\n\r\nWeekly bouldering at City Bouldering, Aldgate. Includes entry, shoe hire, and chalk hire.\r\n\r\nThe event is suitable for all ability levels, if you\'re a beginner and would like some tips to get started let us know.\r\n\r\nFeel free to request a place after the deadline on the event (up until lunch time the day of).\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="location"\r\n\r\nCity Bouldering Aldgate\r\n33 Aldgate High Street, London, EC3N 1AH\r\n(10 minutes walk from London Fenchurch Street Office)\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="cost"\r\n\r\n£5 for SSC members; See https://www.citybouldering.co.uk/pricing (Pay As You Go section) for guest pricing\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="instructions"\r\n\r\nFeel free to request a place after the deadline on the event (up until lunch time the day of).\r\nThere are a few bits of admin to do beforehand, please complete them before the event:\r\n* Please ensure you pre-register at the City Bouldering website (https://www.citybouldering.co.uk/pre-register) to avoid delays. (Pay attention to the video as they will ask you a few basic safety questions when you arrive).\r\n* The SSC requires a disclaimer to be filled out in order to attend, please fill out the form with ‘Regular Event’ as the ‘Event Date’ then email to me before your first session. Available here: https://cgigbr-my.sharepoint.com/:w:/g/personal/sam_molyneux_cgi_com/EdReAPVlKo9Dh9s473DYMhwBmfbNbV8aF_vBEpM_MQ9n_Q?e=7z1dJu\r\nOtherwise, all you need to do is turn up any time after 5 30 with comfortable sports clothing and your **CGI ID** then give your name at reception. Lockers are available and require either a padlock or pound coin to use.\r\n*Please pay £5 to the below bank details:\r\nLONDON SPORTS & SOCIAL CLUB CGI UK\r\nTREASURERS ACCOUNT\r\nSORT CODE: 30-98-90\r\nACCOUNT: 16111060\r\nREFERENCE: <NAME> CLIMB02\r\n\r\nFeel free to send any questions my way.\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="start"\r\n\r\n2026-01-20 18:00:00\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="end"\r\n\r\n2026-01-20 21:00:00\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="deadline"\r\n\r\n2026-01-20 10:30:00\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="organiser"\r\n\r\n3482\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="organiser2"\r\n\r\n3146\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="club"\r\n\r\nlon\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="options[0][title]"\r\n\r\n\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7\r\nContent-Disposition: form-data; name="options[0][options]"\r\n\r\n\r\n------WebKitFormBoundaryBmNswQvNxABq8Qd7--\r\n'
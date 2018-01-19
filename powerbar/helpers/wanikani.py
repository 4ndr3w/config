#!/usr/bin/env python
import sys
import time
import requests

while True:
    try:
        r = requests.get("https://www.wanikani.com/api/user/dsafasdfdsaf/study-queue")
        if r:
            data = r.json()
            print("K"+str(data['requested_information']['reviews_available']))
            sys.stdout.flush()
    except Exception:
        pass
    if len(sys.argv) == 1:
        time.sleep(60*10)
    else:
        break

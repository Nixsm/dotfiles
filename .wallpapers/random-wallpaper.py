#!/usr/bin/env python3

import requests
import json
import subprocess
from urllib import request

timeout = 0;

while True:
    try:
        r = requests.get("http://www.google.com")
        if r.status_code == 200 or timeout > 15:
            break;
        timeout += 1
    except:
        pass

jsonText = ""

while True:
    r = requests.get('https://api.desktoppr.co/1/wallpapers/random')

    jsonText = json.loads(r.text)
    if jsonText['response']['width'] >= 2560 and jsonText['response']['height'] >= 1080:
        break

imageUrl = jsonText['response']['image']['url']

path = "/Users/nicholas/.wallpapers/downloaded.jpg"

f = open(path, 'wb')
f.write(request.urlopen(imageUrl).read())
f.close()

SCRIPT = """/usr/bin/osascript<<END
tell application "Finder"
set desktop picture to POSIX file "%s"
end tell
END"""

subprocess.Popen(SCRIPT%path, shell=True)
subprocess.call("killall Dock", shell=True)

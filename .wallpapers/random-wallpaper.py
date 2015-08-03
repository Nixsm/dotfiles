#!/usr/bin/env python3

import requests
import json
import subprocess

while True:
    try:
        r = requests.get("http://www.google.com")
        if r.status_code == 200:
            break;
    except:
        pass

jsonText = ""

while True:
    r = requests.get('https://api.desktoppr.co/1/wallpapers/random?width=2560')

    jsonText = json.loads(r.text)
    if jsonText['response']['width'] >= 2560:
        break

imageUrl = jsonText['response']['image']['url']


path = "/Users/nicholas/.wallpapers/downloaded.jpg"

r = requests.get(imageUrl, stream=True)
f = open(path,'wb')
f.write(requests.get(imageUrl).content)
f.close()

SCRIPT = """/usr/bin/osascript<<END
tell application "Finder"
set desktop picture to POSIX file "%s"
end tell
END"""

subprocess.Popen(SCRIPT%path, shell=True)
subprocess.call("killall Dock", shell=True)

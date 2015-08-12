import requests
import subprocess

path="/Users/nicholas/.wallpapers/nicholas.jpg"

SCRIPT = """/usr/bin/osascript<<END
tell application "Finder"
set desktop picture to POSIX file "%s"
end tell
END"""

subprocess.Popen(SCRIPT%path, shell=True)
subprocess.call("killall Dock", shell=True)

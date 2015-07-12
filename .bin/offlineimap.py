#!/usr/bin/env python
import subprocess
import os

def mailpasswd(acct):
    acct = os.path.basename(acct)
    path = os.getenv("HOME") + "/.pwds/%s.gpg" % acct
    args = ["gpg2", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args).strip()
    except subprocess.CalledProcessError:
        return ""

#!/usr/bin/python

# Set primary UID and add any additional UIDs

import os 

primary_uid = os.environ["PRIMARY_UID"]
uid_string = os.environ["ADD_UIDS"]
gpg_adduid = "gpg --quick-adduid " + primary_uid + " " + uids[i]

# Set the first UID as the Primary UID before adding more
os.system("echo 'uid 1\nprimary\nsave\n' | gpg --command-fd 0 --edit-key " + primary_uid)

# Add each uid
uids = uid_string.split(", ")
for i in range(len(uids)):
    os.system(gpg_adduid)

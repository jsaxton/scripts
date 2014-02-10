#!/bin/bash

export PASSPHRASE="passphrase"
BACKUP_PATH=scp://user@host//path/to/backups
ARGS="--encrypt-key KEYID --full-if-older-than 30D"

# Personal KeePass database (Do not encrypt -- includes my GPG password)
# Note: Needs to be restored with the --no-encryption option as well
duplicity --full-if-older-than 30D --no-encryption /data/personal.kdbx $BACKUP_PATH/personal.kdbx

# Symantec KeePass database
duplicity $ARGS /home/jsaxton/Downloads/Symantec.kdbx $BACKUP_PATH/symantec.kdbx

# Pictures
duplicity $ARGS /data/pictures $BACKUP_PATH/pictures

# Taxes
duplicity $ARGS /data/taxes $BACKUP_PATH/taxes

# Mindy's stuff
duplicity $ARGS /data/MindyBackups/Remote $BACKUP_PATH/mindy

# homedir stuff 
duplicity $ARGS --include /home/jsaxton/Documents --include /home/jsaxton/TextFiles --include /home/jsaxton/blog --include /home/jsaxton/code --exclude '**' /home/jsaxton $BACKUP_PATH/john

# Clean up old stuff (I intentionally don't do this with the kdbx files)
duplicity remove-all-but-n-full 3 --force $BACKUP_PATH/pictures
duplicity remove-all-but-n-full 3 --force $BACKUP_PATH/taxes
duplicity remove-all-but-n-full 3 --force $BACKUP_PATH/mindy
duplicity remove-all-but-n-full 3 --force $BACKUP_PATH/john

# TODO: Email me if stuff breaks

unset PASSPHRASE

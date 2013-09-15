#!/bin/bash

# I host my own private git repositories in order to remain compliant with the
# Coursera honor code. I keep a copy of this script in /opt/git and use it to
# create new repositories as needed.

# Syntax: ./create_repo.sh <repo name>

if [ ! $# == 1 ]; then
	echo "Syntax: ./create_repo.sh <repo name>"
	exit 1
fi

if [ -d $1 ]; then
	echo "$1 already exists, exiting"
	exit 1
fi

git init --bare --shared=group $1
chgrp -R git-users $1

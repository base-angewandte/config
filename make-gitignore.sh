#!/bin/bash

export LC_ALL=en_GB.UTF-8

if [ -e .gitignore ]; then
	echo -n "You already have a .gitignore file in this folder. Do you want to overwrite it? [y/N] "
	read -r answer
	if [ "${answer}" != "y" ]; then
		echo "Aborting due to existing .gitignore file"
		exit
	fi
	echo
fi

echo "Creating new .gitignore file from templates"
printf "# .gitignore generated by make gitignore on %s" "$(date +'%a %-d %b %Y %H:%M:%S %Z')" >.gitignore

{
	printf '\n\n### MacOS\n'
	curl https://raw.githubusercontent.com/github/gitignore/main/Global/macOS.gitignore
	printf '\n\n### JetBrains\n'
	curl https://raw.githubusercontent.com/github/gitignore/main/Global/JetBrains.gitignore
	printf '\n\n### VS Code\n'
	curl https://raw.githubusercontent.com/github/gitignore/main/Global/VisualStudioCode.gitignore
	printf '\n\n### Python\n'
	curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore
} >>.gitignore

{
	printf '\n\n### base ignores\n'
	printf '.idea\n'
	printf '.python-version\n'
	printf '.editorconfig\n'
	printf 'compose.override.yaml\n'
	printf 'docker-compose.override.yml\n'
	printf 'dockerdata\n'
	printf 'logs\n'
	printf 'docs/build\n'
	printf 'secret_key.py\n'
} >>.gitignore

if [ -f .gitignore.local ]; then
	printf '\n\n### Project\n' >>.gitignore
	cat .gitignore.local >>.gitignore
fi

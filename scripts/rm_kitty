BASHRC_MAGIC="#ScriptKittyBashrcMagicGk3B5N7iMPJ4caKpmK6aZuVRDUApdzDIvu6RmowI"
BASHRC_FILE=~/.bashrc
SCRIPTS_DIR=~/.scripts

# prompt user to make sure they want to remove script_kitty:
if [ "$1" != "-y" ]; then
	echo "This operation will remove the kitty section from your .bashrc file and delete ~/.scripts directory."
	read -p "Are you sure you want to remove script_kitty? (y/n) " -n 1 -r
	echo
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		exit 1
	fi
fi

# remove kitty section from bashrc:
sed -i "/$BASHRC_MAGIC/,/$BASHRC_MAGIC/d" "$BASHRC_FILE"

# remove scripts dir:
rm -rf "$SCRIPTS_DIR"
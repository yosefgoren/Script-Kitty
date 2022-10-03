# 'BASHRC_MAGIC' will be added before and after the .bashrc section which is managed by script_kitty.
BASHRC_MAGIC="#ScriptKittyBashrcMagicGk3B5N7iMPJ4caKpmK6aZuVRDUApdzDIvu6RmowI"
BASHRC_FILE=~/.bashrc
SCRIPTS_DIR=~/.scripts
SCRIPTS_ORIGIN=./scripts

#copy init_kitty and rm_kitty to scripts origin:
cp init_kitty.sh $SCRIPTS_ORIGIN/init_kitty
cp rm_kitty.sh $SCRIPTS_ORIGIN/rm_kitty

# Remove old kitty section if it already exists:
if grep -q "$BASHRC_MAGIC" "$BASHRC_FILE"; then
	sed -i "/$BASHRC_MAGIC/,/$BASHRC_MAGIC/d" "$BASHRC_FILE"
fi

# add new kitty section:
echo "$BASHRC_MAGIC" >> "$BASHRC_FILE"
echo "# This section is managed by script_kitty:" >> "$BASHRC_FILE"
echo "export PATH=\"$SCRIPTS_DIR:\$PATH\"" >> "$BASHRC_FILE"
echo "$BASHRC_MAGIC" >> "$BASHRC_FILE"

# make scripts dir if it does not already exist:
mkdir -p "$SCRIPTS_DIR"

# add execute permissions to all scripts in orgin dir:
chmod +x "$SCRIPTS_ORIGIN"/*

# copy all scripts from origin dir to scripts dir:
cp "$SCRIPTS_ORIGIN"/* "$SCRIPTS_DIR"

# re-run bashrc:
source "$BASHRC_FILE"

# print success message:
echo "Successfully installed script_kitty!"





# 'BASHRC_MAGIC' will be added before and after the .bashrc section which is managed by script_kitty.
BASHRC_MAGIC="#ScriptKittyBashrcMagicGk3B5N7iMPJ4caKpmK6aZuVRDUApdzDIvu6RmowI"
BASHRC_FILE=~/.bashrc
SCRIPTS_DIR=~/.scripts
SCRIPTS_ORIGIN=./scripts
COMPLETIONS_SRC_DIR=./completions
COMPLETIONS_DST_DIR=~/.scripts/completions

#TODO: make init_kitty work from ~/.scripts/init_kitty (currently only works from repo root as current dir).

function list_files() {
  local dir="$1"
  cd "$dir"
  for file in *; do
    echo "${file##*/}"
  done
}


#copy init_kitty and rm_kitty to scripts origin:
cp init_kitty.sh $SCRIPTS_ORIGIN/init_kitty
cp rm_kitty.sh $SCRIPTS_ORIGIN/rm_kitty
# make scripts dir if it does not already exist:
mkdir -p "$SCRIPTS_DIR"
# add execute permissions to all scripts in orgin dir:
chmod +x "$SCRIPTS_ORIGIN"/*
# copy all scripts from origin dir to scripts dir:
cp "$SCRIPTS_ORIGIN"/* "$SCRIPTS_DIR"

# make completions dir on target and copy content:
# mkdir -p "$COMPLETIONS_DIR"
cp -r $COMPLETIONS_SRC_DIR $COMPLETIONS_DST_DIR

# copy scripts appdata to .scripts dir:
cp -r ./appdata "$SCRIPTS_DIR"

# Remove old kitty section if it already exists:
if grep -q "$BASHRC_MAGIC" "$BASHRC_FILE"; then
	sed -i "/$BASHRC_MAGIC/,/$BASHRC_MAGIC/d" "$BASHRC_FILE"
fi
# add new kitty section:
echo "$BASHRC_MAGIC" >> "$BASHRC_FILE"
echo "# This section is managed by script_kitty:" >> "$BASHRC_FILE"
#managing path variable:
echo "export PATH=\"$SCRIPTS_DIR:\$PATH\"" >> "$BASHRC_FILE"
#adding script completions:
#for each file in the format $SCRIPTS_ORIGIN/completions/comp_<script_name>.sh, check there is <script_name> file in $SCRIPTS_ORIGIN, and if so, add the line:
#source $SCRIPTS_ORIGIN/completions/comp_<script_name>.sh && complete -F _comp_<script_name> <script_name>
#debugging:
for file_name in $(list_files "$COMPLETIONS_DST_DIR"); do
	# remove _comp_ prefix:
	function_name="${file_name%.*}"
  # remove .sh suffix:
  script_name="${function_name#comp_}"
	echo "source $COMPLETIONS_DST_DIR/$file_name && complete -F _$function_name $script_name" >> "$BASHRC_FILE"
done
echo "$BASHRC_MAGIC" >> "$BASHRC_FILE"
# re-run bashrc:
source "$BASHRC_FILE"

# print success message:
echo "Successfully installed script_kitty!"





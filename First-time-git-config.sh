# sets up Git with your name
git config --global user.name "Harish Osthe"

# sets up Git with your email
git config --global user.email "Harishosthe@gmail.com"

# makes sure that Git output is colored
git config --global color.ui auto

# displays the original state in a conflict
git config --global merge.conflictstyle diff3

git config --list

# Git & Code Editor setup
# git config --global core.editor "atom --wait"
# git config --global core.editor "'/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl' -n -w"
git config --global core.editor "code --wait"

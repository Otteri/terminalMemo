# terminalMemo
Simple framework for keeping and accessing a memo through a terminal. The memo files shall contain only text so they can be outputted to the terminal.

# Installation
Clone the repository and then add your notes to the repository's root directory. Thats it, you're done! Just make sure that the Contents.sh file can be executed (chmod +x) and your notes are plain text files.

# Usage
Run Contents.sh script from the terminal (`./Contents.sh`).

## Tips
The usability of the memo is quite poor without doing any additional tricks. What should be done depends higly on how the memo is going to be used and also what platform you have. I use the memo to store some git commands that I cannot remember by hearth, so creating a *git alias* can be a good idea.  
Put the following (with modified path of course) to your *.gitconfig*
```bash
memo = "!f() { C:/base/path/Contents.sh; }; f"
```
Now command `$git memo` allows you to access to the personal notes from any directory location. Alternatively, If you are using bash, then you can also create a bash alias to *.bashrc*
```bash
alias memo="C:/base/path/Contents.sh"
```
Now you need to call only `$memo` to access your notes. This latter way makes probably much more sense if your notes are not related to git anyhow.
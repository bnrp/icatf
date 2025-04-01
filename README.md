# icatf
Bash script for simpler displaying of images in folders using the kitty terminal emulator's icat command. Specifically I made this so I can easily output the names of an image next to its display.

### Installation
Download `icatf.sh` and add the line `alias icatf = bash <path to icatf.sh>/icatf.sh` in your `.bashrc`.

### Usage
The command can be used with flags:
```
icatf [d subdirectory] [p file prefix] [s]
```
#### d)
If the subdirectory flag `-d` is not used, the current working directory is the output of `pwd`, otherwise, the input subdirectory is appended to the output of `pwd`. 
#### p)
If the prefix flag `-p` is not used, the command simply displays all `.jpg`, `.jpeg`, and `.png` files in the given subdirectory. Note that this does not recursively search child folders.
#### s)
If the silence flag `-s` is used, extraneous print lines are ignored. This flag takes no argument.


The command can also be used without flags and with positional arguments:
```
icatf <subdirectory> <file prefix>
```
Here, `.` can be used in place of subdirectory to use the output of `pwd` as the working directory. If no prefix is utilized, all `.jpg`, `.jpeg`, and `.png` files will be displayed. The extra print lines are always printed with the positional arguments.

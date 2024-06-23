# Find or remove identical json files
Compare JSON files character by character after removing spaces and indentations, optionally show or remove duplicates using trash command.

> trash command (Optional): The script uses the trash command to move files to the macOS Trash instead of deleting them permanently. If you haven’t installed trash, you can do so using Homebrew by running:
```
brew install trash
```

**Run the script with -h to see the help message and understand how to use the various flags.**

### Explanation:
- **show_duplicates:** The function now initializes `found_duplicates` to False and checks each group of files for duplicates. If any duplicates are found (len(filenames) > 1), it sets found_duplicates to True and prints the group of filenames. If no duplicates are found, it prints “No duplicate files present.”
- **main:** The main function remains structured to handle command-line arguments (-d, -s, -r) using argparse. Depending on the flags provided, it either shows duplicate files (-s), removes duplicate files (-r), or both.

### **For Example**
```
python3 find_remove_duplicates.py -h
```

```
usage: find_remove_duplicates.py [-h] -d DIRECTORY [-s] [-r]

Compare JSON files character by character after removing spaces and indentations, optionally show or remove duplicates.

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --directory DIRECTORY
                        Directory path containing JSON files.
  -s, --show-duplicates
                        Show files with identical content (after removing spaces and indentations) grouped
                        together.
  -r, --remove-duplicates
                        Remove duplicate files, leaving one file per group of identical files.
```
# gf-pattern-collector
This script collect gf pattern from different github repos.

### Pre-requisite

> **Install trash command:** If you haven’t installed trash on your macOS, you can install it using Homebrew:
```
brew install trash
```
**Change the TARGET_DIR according to your need**

> If you don’t have the necessary permissions, change the permissions:
```
chmod u+w $HOME/.gf
```
**Explanation:**
1. Preprocessing Function (preprocess):
    - This function uses sed to remove all whitespace characters ([[:space:]]) from the file, effectively ignoring spaces and indentations.
2.	Comparison with Preprocessing:
	- Inside the move_file function, diff is used to compare the preprocessed versions of the files.
	- If the preprocessed files are identical, the script skips moving the file.

This approach ensures that files are compared based on their actual content, ignoring differences in spaces and indentations.

> **Flaw** : Script is comparing the file name of ~/.gf directory and git file if name matches then it checks for content . If content doesn't matches then it attach timestamp with the github file and move it into  ~/.gf directory. But flaw is here that if new incoming github file's content matches with last moved file then also script will move the new file into ~/.gf directory because name doesn't matches (because last time name was changed by attaching timestamp).

> We can solve this problem using tool `remove-duplicate-json-files`
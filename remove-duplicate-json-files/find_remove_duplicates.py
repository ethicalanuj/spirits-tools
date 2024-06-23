import os
import argparse
import subprocess

def remove_whitespace_and_indentations(content):
    """Remove all whitespace characters (spaces, tabs, newlines) and indentations."""
    return ''.join(content.split())

def compare_files(directory):
    """Compare files character by character after removing spaces and indentations."""
    files = os.listdir(directory)
    file_contents = {}

    for filename in files:
        if filename.endswith('.json'):
            filepath = os.path.join(directory, filename)
            with open(filepath, 'r', encoding='utf-8') as file:
                content = file.read()
                stripped_content = remove_whitespace_and_indentations(content)
                if stripped_content not in file_contents:
                    file_contents[stripped_content] = []
                file_contents[stripped_content].append(filename)

    return file_contents

def show_duplicates(directory):
    """Show duplicate JSON files grouped by identical content (after removing spaces and indentations)."""
    file_contents = compare_files(directory)

    # Check if any duplicates exist
    found_duplicates = False

    # Print files grouped by identical content
    for content, filenames in file_contents.items():
        if len(filenames) > 1:
            found_duplicates = True
            print(f"Identical files (after removing spaces and indentations):")
            for filename in filenames:
                print(f"\t{filename}")
            print()

    if not found_duplicates:
        print("No duplicate files present.")

def remove_duplicates(directory):
    """Remove duplicate JSON files using trash command, leaving one file per group of identical files."""
    file_contents = compare_files(directory)
    files_removed = 0

    # Track which files have been removed
    removed_files = set()

    # Determine files to remove
    for content, filenames in file_contents.items():
        if len(filenames) > 1:
            # Keep the first file, remove the rest
            files_to_remove = filenames[1:]
            for filename_to_remove in files_to_remove:
                try:
                    filepath = os.path.join(directory, filename_to_remove)
                    if os.path.exists(filepath):
                        subprocess.run(['trash', filepath])
                        print(f"Moved file to trash: {filename_to_remove}")
                        files_removed += 1
                        removed_files.add(filename_to_remove)
                    else:
                        print(f"File {filename_to_remove} does not exist at path {filepath}")
                except Exception as e:
                    print(f"Error moving file {filename_to_remove} to trash: {str(e)}")

    return files_removed

def main():
    parser = argparse.ArgumentParser(description="Compare JSON files character by character after removing spaces and indentations, optionally show or remove duplicates.")
    parser.add_argument('-d', '--directory', required=True, help="Directory path containing JSON files.")
    parser.add_argument('-s', '--show-duplicates', action='store_true', help="Show files with identical content (after removing spaces and indentations) grouped together.")
    parser.add_argument('-r', '--remove-duplicates', action='store_true', help="Remove duplicate files, leaving one file per group of identical files.")
    args = parser.parse_args()

    directory = args.directory

    if not os.path.isdir(directory):
        print(f"Error: Directory '{directory}' does not exist.")
        return

    if args.show_duplicates:
        show_duplicates(directory)

    if args.remove_duplicates:
        files_removed = remove_duplicates(directory)
        print(f"Removed {files_removed} duplicate files.")

if __name__ == "__main__":
    main()
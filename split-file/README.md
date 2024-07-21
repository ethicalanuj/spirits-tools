## split-file

`split-file` is a simple Python script for extracting and copying specific lines from a file to another file. It's designed to handle files containing URLs or any other line-separated data, allowing you to specify a range of lines to extract.

### Features

- **Copy Specific Lines**: Extract a specific range of lines from an input file.
- **Flexible Range Specification**: Choose start and end lines to customize the extraction range.
- **Error Handling**: Provides clear error messages for common issues, such as invalid line numbers and file read/write errors.

### Usage


1. **Prepare Your Input File**

   Ensure your input file (e.g., `urls.txt`) contains the data you want to process, with each entry on a new line.

2. **Run the Script**

   Use the following command to execute the script:

   **For Help**
    ```sh
    python3 split-file.py -h
    ```

   ```sh
   python3 split-file.py -i <input_file> -o <output_file> -s <start_line> -e <end_line>
   ```
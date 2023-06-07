#!/bin/bash

PROTO_DIR="."

# Find all .proto files in the proto directory and generate the corresponding files
find "$PROTO_DIR" -name "*.proto" -print0 | while IFS= read -r -d '' file; do
    # Extract the directory and filename without extension
    dir=$(dirname "$file")
    filename=$(basename "$file" .proto)

    # Generate the Go protobuf files in the same directory as the source file
    protoc --proto_path="$PROTO_DIR"  --go_out="$dir/.." --go-grpc_out="$dir/.." "$file"

    # Optionally, generate other target language files if needed
    # protoc --proto_path="$PROTO_DIR" --<target_language>_out="$dir" "$file"
done

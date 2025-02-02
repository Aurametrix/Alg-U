#!/bin/bash

# Validate that the first argument is an integer
if [[ ! $1 =~ ^[0-9]+$ ]]; then
  echo "Please provide a valid integer as the first argument."
  exit 1
fi

id="$1"

# Parse the optional -m argument
model="haiku"
if [[ $2 == "-m" && -n $3 ]]; then
  model="$3"
fi

# Make API call, parse and summarize the discussion
curl -s "https://hn.algolia.com/api/v1/items/$id" | \
  jq -r 'recurse(.children[]) | .author + ": " + .text' | \
  llm -m "$model" -s 'Summarize the themes of the opinions expressed here.
  For each theme, output a markdown header.
  Include direct "quotations" (with author attribution) where appropriate.
  You MUST quote directly from users when crediting them, with double quotes.
  Fix HTML entities. Output markdown. Go long.'

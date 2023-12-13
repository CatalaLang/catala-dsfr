#!/bin/bash

check_latest_version () {
    local latest_version

    latest_version=$(curl "https://registry.npmjs.org/@catala-lang/$1/latest" -s | grep -oP '"version":"\K[0-9]+\.[0-9]+(\.[0-9]+)?(-[a-zA-Z]+(\.[0-9]+)?)?')

    echo "[info]    Latest version: $latest_version"
    if [ -d "node_modules/@catala-lang/$1-$latest_version" ]; then
	echo "[info]    Already up to date"
    else
	echo "[info]    Adding latest version $latest_version"
	yarn add -D "@catala-lang/$1-$latest_version@npm:@catala-lang/$1@$latest_version"
	echo "[done]    Added latest version $latest_version"
    fi
}

copy_files () {
    local package_name
    local files_to_copy
    local version_number

    package_name="$1"
    shift 1

    echo "[info] Removing directory $package_name"
    rm -r "$package_name"

    echo "[info] Checking latest version for @catala-lang/$package_name"
    check_latest_version "$package_name"

    files_to_copy=("$@")

    for folder in node_modules/@catala-lang/$package_name*; do
	version_number=""
	if [ -L "$folder" ]; then 
	    # found a symlink created by yarn link
	    version_number=$(echo "local")
	elif [ -d "$folder" ]; then
	    version_number=$(echo "$folder" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?(-[a-zA-Z]+(\.[0-9]+)?)?')
	fi

	if [ -n "$version_number" ]; then
	    local dest="$package_name/$version_number"

	    mkdir -p "$dest"

	    for file in "${files_to_copy[@]}"; do
		cp "$folder/$file" "$dest"
	    done

	    echo "[done] Created $dest"
	fi
    done
}

assets_files=(
    "assets/allocations_familiales.html"
    "assets/allocations_familiales_schema_fr.json"
    "assets/allocations_familiales_ui_schema_fr.json"
    "assets/aides_logement.html"
    "assets/aides_logement_schema_fr.json"
    "assets/aides_logement_ui_fr.schema.jsx"
    "assets/aides_logement_init.json"
)
copy_files "catala-web-assets" "${assets_files[@]}"

french_law_files=("src/french_law.js")
copy_files "french-law" "${french_law_files[@]}"

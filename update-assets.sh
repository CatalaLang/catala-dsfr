#!/bin/bash

check_latest_version () {
    local latest_version=$(curl "https://registry.npmjs.org/@catala-lang/$1/latest" -s | grep -oP '"version":"\K[0-9]+\.[0-9]+(\.[0-9]+)?(-[a-zA-Z]+(\.[0-9]+)?)?')

    echo "[info]    Latest version: $latest_version"
    if [ -d "node_modules/@catala-lang/$1-$latest_version" ]; then
	echo "[info]    Already up to date"
    else
	echo "[info]    Adding latest version $latest_version"
	yarn add @catala-lang/$1-$latest_version@npm:@catala-lang/$1@$latest_version
	echo "[info]    Done"
    fi
}

copy_files () {
    echo "[info] Updating $1..."

    local package_name="$1"
    shift 1

    echo "[info] Checking latest version for @catala-lang/$package_name.."
    check_latest_version "$package_name"

    local files_to_copy="$@"

    for folder in node_modules/@catala-lang/$package_name-*; do
	if [ -d "$folder" ]; then
	    local version_number=$(echo "$folder" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?(-[a-zA-Z]+(\.[0-9]+)?)?')
	    local dest="$package_name/$version_number"

	    mkdir -p "$dest"

	    for file in $files_to_copy; do
		cp $folder/$file $dest
	    done

	    echo "[info] Created $dest"
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

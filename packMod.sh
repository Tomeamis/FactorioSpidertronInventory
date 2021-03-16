#!/usr/bin/env bash

FolderName=$(jq -r '.name' info.json)_$(jq -r '.version' info.json)
mkdir -p $FolderName
cp *.lua info.json LICENSE $FolderName
zip -r ${FolderName}.zip $FolderName
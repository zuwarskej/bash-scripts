#!/bin/bash

echo "Enter a directory:"
read -r x
du -sh --time "$x"

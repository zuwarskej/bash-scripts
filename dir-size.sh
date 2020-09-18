#!/bin/bash

echo "Enter a directory:"
read x
du -sh --time "$x"

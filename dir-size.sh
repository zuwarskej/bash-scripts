#!/bin/bash
# ----------------------
# Written by: zuwarskej
# ----------------------

echo "Enter a directory:"
read x
du -sh --time "$x"

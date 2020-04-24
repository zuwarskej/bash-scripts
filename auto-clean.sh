#!/bin/bash
# ---------------------------------------------------------
# Descryption: clean and remove old packages Debian/Ubuntu
# Written by : zuwarskej
# ---------------------------------------------------------

if apt-get purge --auto-remove -yqq && apt-get clean; then
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc /usr/share/doc-base;
        echo "done"
fi

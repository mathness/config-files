#!/bin/sh
# Copyright (c) 2007 Aristotle Pagaltzis
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

set -e

exists() { which "$1" &> /dev/null ; }

if ! [ -d ~/.fonts ] ; then
	exec 2>&1
	echo 'There is no .fonts directory in your home.'
	echo 'Is fontconfig set up for privately installed fonts?'
	exit 1
fi

# split up to keep the download command short
DL_HOST=download.microsoft.com
DL_PATH=download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26
ARCHIVE=PowerPointViewer.exe
URL="http://$DL_HOST/$DL_PATH/$ARCHIVE"

if ! [ -e "$ARCHIVE" ] ; then
	if   exists curl  ; then curl -O "$URL"
	elif exists wget  ; then wget    "$URL"
	elif exists fetch ; then fetch   "$URL"
	fi
fi

TMPDIR=`mktemp -d`
trap 'rm -rf "$TMPDIR"' EXIT INT QUIT TERM

cabextract -L -F ppviewer.cab -d "$TMPDIR" "$ARCHIVE"

cabextract -L -F '*.TT[FC]' -d ~/.fonts "$TMPDIR/ppviewer.cab"

( cd ~/.fonts && mv cambria.ttc cambria.ttf && chmod 600 \
	calibri{,b,i,z}.ttf cambria{,b,i,z}.ttf candara{,b,i,z}.ttf \
	consola{,b,i,z}.ttf constan{,b,i,z}.ttf corbel{,b,i,z}.ttf )

fc-cache -fv ~/.fonts


#!/bin/bash

youtube-dl -t --max-quality 37 --extract-audio --audio-format mp3 --audio-quality 256k $1


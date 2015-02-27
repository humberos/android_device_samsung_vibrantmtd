#!/bin/sh
#
# Copyright (C) 2013 OmniROM Project
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

VENDOR=samsung
DEVICE=vibrantmtd
COMMON=aries-common

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

# Get common files
(cd ../$COMMON && ./extract-files.sh)

echo "Pulling device files..."
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
done

# Modem
echo "Pulling modem..."
adb pull /radio/modem.bin $BASE/modem.bin

./setup-makefiles.sh

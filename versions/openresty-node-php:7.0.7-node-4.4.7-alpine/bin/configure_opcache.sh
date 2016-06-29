#!/usr/bin/env bash

# resolve real path to script including symlinks or other hijinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ ${TARGET} == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    BIN="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$BIN')"
    SOURCE="$BIN/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
RBIN="$( dirname "$SOURCE" )"
BIN="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
DIR="$( cd -P "$BIN/../" && pwd )"
ETC="$( cd -P "$DIR/etc" && pwd )"
PHPINI="$ETC/php/php.ini"

# If DEBUG isn't set or debug is true
if [ -z "$DEBUG" ] || [ "$DEBUG" = "true" ]; then
    if ! grep -Fxq ";opcache.validate_timestamps=0" "$PHPINI"; then
        sed -i -e "s/opcache.validate_timestamps=0/;opcache.validate_timestamps=0/g" ${PHPINI}
    fi
else
    if grep -Fxq ";opcache.validate_timestamps=0" "$PHPINI"; then
        sed -i -e "s/;opcache.validate_timestamps=0/opcache.validate_timestamps=0/g" ${PHPINI}
    fi
fi
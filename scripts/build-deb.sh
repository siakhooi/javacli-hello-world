#!/bin/bash

TARGET=target/deb
SOURCE=src/deb
SOURCE_JAR=$(ls target/*-with-dependencies.jar)

mkdir -p $TARGET

# Control File
cp -vr $SOURCE/DEBIAN $TARGET

# Binary File
cp -vr $SOURCE/usr $TARGET
chmod 755 $TARGET/usr/bin/*

# Jar File
mkdir -p $TARGET/usr/lib/java/siakhooi
cp -v "$SOURCE_JAR" $TARGET/usr/lib/java/siakhooi

fakeroot dpkg-deb --build -Zxz $TARGET
dpkg-name ${TARGET}.deb

DEBFILE=$(ls ./target/*.deb)

sha256sum "$DEBFILE" >$DEBFILE.sha256sum
sha512sum "$DEBFILE" >$DEBFILE.sha512sum

dpkg --contents "$DEBFILE"

cp $DEBFILE .
cp $DEBFILE.sha256sum .
cp $DEBFILE.sha512sum .

#!/usr/bin/env bash

export CLANG_MSVC_SDK=$PWD

# Get msvc stuff
nuget install VisualCppTools.Community.VS2017Layout -Version 14.11.25506 -OutputDirectory $CLANG_MSVC_SDK/msvc_nuget
mv msvc_nuget/VisualCppTools.Community.VS2017Layout.14.11.25506/lib/native/* $CLANG_MSVC_SDK/msvc/

# Get win10sdk
export WINEPREFIX=$CLANG_MSVC_SDK/wine
wget -O win10sdk.iso https://go.microsoft.com/fwlink/p/?linkid=870809
mkdir win10sdk_iso
cd win10sdk_iso
7z x ../win10sdk.iso
cd Installers
wine wineboot --init
wine msiexec /i "Windows SDK Desktop Headers x64-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK Desktop Headers x86-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK Desktop Libs x64-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK Desktop Libs x86-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK Desktop Tools x64-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK Desktop Tools x86-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK for Windows Store Apps Headers-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK for Windows Store Apps Libs-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK for Windows Store Apps Tools-x86_en-us.msi" /qn
wine msiexec /i "Windows SDK for Windows Store Apps Legacy Tools-x86_en-us.msi" /qn
wine msiexec /i "Universal CRT Headers Libraries and Sources-x86_en-us.msi" /qn

mv $WINEPREFIX/drive_c/Program\ Files\ \(x86\)/Windows\ Kits/10 $CLANG_MSVC_SDK/winsdk

# Cleanup
rm -R $CLANG_MSVC_SDK/wine
rm -R $CLANG_MSVC_SDK/win10sdk_iso
rm -R $CLANG_MSVC_SDK/msvc_nuget
rm -R $CLANG_MSVC_SDK/win10sdk.iso

#!/bin/bash

pkg_lucid=""
pkg_precise=""

if [ "$#" -lt "1" ]; then
  echo "[-] Please provide at least one argument."
  exit 1
fi

cat <<HEAD
packages = Array.new

HEAD

if [ "$#" -eq "1" ]; then
  pkg_lucid="$1"
  pkg_precise="$pkg_lucid"

  cat <<DISTBLOCK
case node[:lsb][:codename]
when "lucid", "precise"
  packages |= %w/
    $pkg_lucid
  /
end

DISTBLOCK

elif [ "$#" -eq "2" ]; then
  pkg_lucid="$1"
  pkg_precise="$2"

  cat <<DISTBLOCK
case node[:lsb][:codename]
when "lucid"
  packages |= %w/
    $pkg_lucid
  /
when "precise"
  packages |= %w/
    $pkg_precise
  /
end

DISTBLOCK

fi

cat <<INSTALLBLOCK
packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end
INSTALLBLOCK

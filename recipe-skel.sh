#!/bin/bash

pkgname="$1"

cat <<EOBLOCK
packages = Array.new

case node[:lsb][:codename]
when "lucid"
  packages |= %w/
    $pkgname
  /
when "precise"
  packages |= %w/
    $pkgname
  /
end

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end
EOBLOCK

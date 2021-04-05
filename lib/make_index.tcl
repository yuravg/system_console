#!/usr/bin/env tclsh

# make_index.tcl --
#
#       Script to create an index of available packages.

set packages [list sc_service-1.0 sc_avalonmm-1.0]

puts "Prepare index file for: $packages"

foreach i $packages {
    puts "* Indexing: $i"
    pkg_mkIndex -verbose $i
}

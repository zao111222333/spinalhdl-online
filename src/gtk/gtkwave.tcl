### --------------------------------------------------------------------
### gtkwave.tcl
### Author: Junzhuo ZHOU
### Reference: http://gtkwave.sourceforge.net/gtkwave.pdf
### --------------------------------------------------------------------

# add all TOP signals
set nfacs [gtkwave::getNumFacs ]
set top_facs [list]
for {set i 0} {$i < $nfacs} {incr i} {
set facname [gtkwave::getFacName $i]
    set namelist [split "$facname" .]
    if { [llength $namelist] == 2 } {
        lappend top_facs "$facname"
    }
}
set top_path [lindex $namelist 0]
puts "TOP=$top_path"
# open TOP tree node
switch -- [gtkwave::forceOpenTreeNode $top_path] {
 -1 {puts "Error: SST is not supported here"}
  1 {puts "Error: '$top_path' was not recorder to dump file"}
  0 {puts "Open TreeNode"}
}

# add all TOP signals
# set num_added [gtkwave::addSignalsFromList [lreverse $top_facs]]
set num_added [gtkwave::addSignalsFromList $top_facs]

puts "Added Signals: #$num_added"

# set Marker at time=0
gtkwave::setMarker 0

# zoom full
gtkwave::/Time/Zoom/Zoom_Full

# Print
# set dumpname [ gtkwave::getDumpFileName ]
# gtkwave::/File/Print_To_File PDF {Letter (8.5" x 11")} Minimal $dumpname.pdf
#!/usr/bin/env tclsh
namespace eval ::chat {
    variable count 0
    variable clients {}
}

proc ::chat::main {} {
    socket -server ::chat::new-connection-handler -myaddr 127.0.0.1 7777
    vwait forever
}

proc ::chat::new-connection-handler {channel clientAddr clientPort} {
    incr ::chat::count
    set name client$::chat::count
    lappend ::chat::clients $channel $name

    puts "Incoming connection from ('$clientAddr', $clientPort): $name"
    ::chat::broadcast "$name connected"

    fconfigure $channel -buffering line
    fileevent $channel readable [list ::chat::readable-handler $channel]
}

proc ::chat::broadcast message {
    puts $message
    foreach {otherChannel _} $::chat::clients {
        puts $otherChannel $message
    }
}

proc ::chat::readable-handler channel {
    set senderName [dict get $::chat::clients $channel]
    if {[gets $channel line] >= 0} {
        ::chat::broadcast "$senderName: $line"
    }
    if {[eof $channel]} {
        ::chat::broadcast "$senderName disconnected"
        close $channel
        dict unset ::chat::clients $channel
    }
}

::chat::main

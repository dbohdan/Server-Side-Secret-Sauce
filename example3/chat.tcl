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

    puts "Incoming connection from $clientAddr:$clientPort: $name"

    fconfigure $channel -buffering line
    fileevent $channel readable [list ::chat::readable-handler $channel]
}

proc ::chat::readable-handler {channel} {
    set senderName [dict get $::chat::clients $channel]
    if {[gets $channel line] >= 0} {
        foreach {otherChannel _} $::chat::clients {
            set message "$senderName: $line"
            puts $message
            puts $otherChannel $message
        }
    }
    if {[eof $channel]} {
        puts "$senderName disconnected"
        close $channel
        dict unset ::chat::clients $channel
    }
}

::chat::main

#!/usr/bin/awk -f

BEGIN           { do_echo=0 }

/^WatchedEvent/ { do_echo=1; next }

                { if (do_echo) print $0 }
 
    

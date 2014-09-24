Agent-side Script Installation
-------------------------

a. Place the fiber_channel_unix.ksh file in the directory /opt/uptime-agent/scripts/
   (create the directory if needed)
b. Create/edit the following password file:
   /opt/uptime-agent/bin/.uptmpasswd
   and add the following line to it:

   fc_monitor   /opt/uptime-agent/scripts/fiber_channel_unix.ksh

That's it!
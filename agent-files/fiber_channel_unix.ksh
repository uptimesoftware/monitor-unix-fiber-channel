#!/bin/sh
#
# this script will determine if we have a failed path
# or adapter for external storage. This will bubble up
# to up.time for alerting
#
# Joel Pereira
# 03-26-2013
# Version 1.1
#
# Dan Brownson
# 12-17-2012
# Version 1.0
#
#############################################################
# pcmpath query adapter | grep -i failed
#
# pcmpath query device | grep -i failed
#
# pcmpath query adapter | grep -i degraded
#
# lspath | grep -i failed | wc -l
#
# lspath | grep -i failed | awk '{print $3}' | uniq
#
##############################################################

# first set our variables
LOCKFILE=/tmp/failedpath.lck
LOCKSET=0
PREVFAILED=0
CURFAILED=0
CURFAILEDDEV=0
CURFAILEDADP=0
MYHOST=$(hostname)

# check to see if we have a lock file. We do not want to alert constantly unless we have new information.
if [[ -f ${LOCKFILE} ]];then
        LOCKSET=1
        PREVFAILED=$(cat ${LOCKFILE} )
fi

# now check to see if we have any path errors.
CURFAILED=$(lspath | grep -i failed | awk '{print $2}' | sort | uniq | wc -l)
if [[ ${CURFAILED} -gt 0 ]];then
        # we have one or more failed paths
        # check to see if this is the same as the last time we checked
        if [[ ${CURFAILED} -ne ${PREVFAILED} ]]; then
                # get the devices and adapters with failed resources.
                CURFAILEDADP=$(lspath | grep -i failed | awk '{print $3}' | sort | uniq)
                CURFAILEDDEV=$(lspath | grep -i failed | awk '{print $2}' | sort | uniq)
                echo ${CURFAILED} > ${LOCKFILE}
                echo "Failed paths were found on ${MYHOST}. The following information was provided."
                echo "  Devices: "
                echo "${CURFAILEDDEV}"
                echo "  Adapters:"
                echo "${CURFAILEDADP}"

        else
                echo "We have ${PREVFAILED} failed device(s) on ${MYHOST}. We are still in a failed state."
        fi
else
        if [[ ${PREVFAILED} -gt 0 ]]; then
                echo "Failed paths on ${MYHOST} have recovered"
                rm -f ${LOCKFILE}
        else
                echo "No problems found on ${MYHOST}"
        fi
fi

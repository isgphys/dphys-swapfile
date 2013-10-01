#!/bin/sh
# /etc/init.d/dphys-swapfile - automatically set up an swapfile
# author Neil Franklin, last modification 2006.09.15
# This script is copyright ETH Zuerich Physics Departement,
#   use under either modified/non-advertising BSD or GPL license

# this init.d script is intended to be run from rcS.d
#   must run after  mount  of  /var  which may only happen in  S35mountall.sh
#     for this reason we can not build swapfile until after  S35mountall.sh
#       so we also need to use  init.d start|stop  to swapon|off our file
#   and sensibly before the lots of stuff which may happen in  S40networking
#   so we run it as rcS.d/S37dphys-config

### BEGIN INIT INFO
# Provides:          dphys-swapfile
# Required-Start:    $syslog $remote_fs
# Required-Stop:     $syslog $remote_fs
# Should-Start:      $local_fs
# Should-Stop:       $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Autogenerate and use a swap file
# Description:       This init.d script exists so one does not need to have a fixed size
#                    swap partition. Instead install without swap partition and then run
#                    this, with file size (re-)computed automatically to fit the current
#                    RAM size.
### END INIT INFO

. /lib/lsb/init-functions

# get ready to work
PATH=/sbin:/bin:/usr/sbin:/usr/bin
export PATH

# what we are
NAME=dphys-swapfile

case "$1" in

  start)
    /bin/echo "Starting ${NAME} swapfile setup ..."

    # (re-)size/-generate (and also first time install)
    # this will produce output, so no -n in above echo
    /sbin/dphys-swapfile setup

    # as S35mountall.sh has already run, do this from here
    #   as there can be no swapon in /etc/fstab
    /sbin/dphys-swapfile swapon

    /bin/echo "done."
    ;;


  stop|default-stop)
    /bin/echo -n "Stopping ${NAME} swapfile setup ..."

    # as no swapon or swapoff in /etc/fstab, do this from here
    /sbin/dphys-swapfile swapoff

    /bin/echo ", done."
    ;;


  restart|reload|force-reload|status)
    /bin/echo "No daemon to (force-)re[start|load] or status check in ${NAME}"
    ;;


 *)
    /bin/echo "Usage: $0 {start|stop}"

    exit 1
    ;;

esac

exit 0

#!/bin/bash
/usr/sbin/sshd &
exec apache2ctl -DFOREGROUND

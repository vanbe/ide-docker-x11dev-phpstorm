#!/bin/bash
# Launch with ubuntu user
exec sudo -E -u ubuntu /home/ubuntu/PhpStorm/bin/phpstorm "$@"

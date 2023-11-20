#!/bin/bash
make remove
make install-lib
make reset
read -p "Enter node name: " node_name
make init NODE_NAME="$node_name"
make update-config


if [ "$1" = "start" ]; then
    soarchaind start --log_level info --minimum-gas-prices=0.0001utmotus 
fi

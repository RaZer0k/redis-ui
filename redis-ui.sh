#!/bin/bash
export DOTNET_ROOT=/root/.dotnet
export PATH=$PATH:/root/.dotnet:/root/.dotnet/tools

case "${1}" in
        start)
                echo "starting"
                cd /app && dotnet redis-ui.dll && cd /data
                ;;

        *)
                echo "Usage: ${0} {start}"
                exit 1
                ;;
esac
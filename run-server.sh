#!/bin/sh
set -euo pipefail

cat /config/serverconfig
exec mono --server --gc=sgen -O=all /terraria-server/TerrariaServer.exe -config /config/serverconfig

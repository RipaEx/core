#!/usr/bin/env bash

pm2 delete ark-core > /dev/null 2>&1
pm2 delete ark-core-relay > /dev/null 2>&1
pm2 delete ark-core-forger > /dev/null 2>&1

pm2 delete core > /dev/null 2>&1
pm2 delete core-relay > /dev/null 2>&1
pm2 delete core-forger > /dev/null 2>&1

node ./scripts/upgrade/upgrade.js

# Sometimes the upgrade script doesn't properly replace ARK_ with CORE_
# https://github.com/ArkEcosystem/core/blob/develop/scripts/upgrade/upgrade.js#L206
cd ~

if [ -f .config/xpx-core/devnet/.env ]; then
    sed -i 's/ARK_/CORE_/g' .config/xpx-core/devnet/.env
fi

if [ -f .config/xpx-core/devnet/plugins.js ]; then
    sed -i 's/ARK_/CORE_/g' .config/xpx-core/devnet/plugins.js
fi

if [ -f .config/xpx-core/mainnet/.env ]; then
    sed -i 's/ARK_/CORE_/g' .config/xpx-core/mainnet/.env
fi

if [ -f .config/xpx-core/mainnet/plugins.js ]; then
    sed -i 's/ARK_/CORE_/g' .config/xpx-core/mainnet/plugins.js
fi

cd ~/xpx-core
yarn setup

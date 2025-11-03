#!/bin/bash

native-image \
    -o ibkr-gateway \
    -cp "dist/ibgroup.web.core.iblink.router.clientportal.gw.jar:build/lib/runtime/*:." ibgroup.web.core.clientportal.gw.GatewayStart

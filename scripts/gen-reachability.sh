#!/bin/bash

java \
    -agentlib:native-image-agent=config-output-dir=META-INF/native-image \
    -server \
    -Dvertx.disableDnsResolver=true \
    -Djava.net.preferIPv4Stack=true \
    -Dvertx.logger-delegate-factory-class-name=io.vertx.core.logging.SLF4JLogDelegateFactory \
    -Dnologback.statusListenerClass=ch.qos.logback.core.status.OnConsoleStatusListener \
    -Dnolog4j.debug=true \
    -Dnolog4j2.debug=true \
    -cp "dist/ibgroup.web.core.iblink.router.clientportal.gw.jar:build/lib/runtime/*:." ibgroup.web.core.clientportal.gw.GatewayStart

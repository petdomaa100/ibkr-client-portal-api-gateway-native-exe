#!/bin/bash

keytool -genkey -keyalg RSA -alias selfsigned -keystore vertx.jks -storepass mywebapi -validity 365 -keysize 2048

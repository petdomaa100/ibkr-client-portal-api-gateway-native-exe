# IBKR Client Portal API Native Executable

This project packages the IBKR Client Portal API Gateway as a native executable. I created this to avoid installing Java on my home server and keep the deployment independent of the JVM as the surrounding stack doesn't use Java.

Prebuilt binaries are available for Linux, macOS, and Windows in the repository's [releases](https://github.com/petdomaa100/ibkr-client-portal-api-gateway-native-exe/releases). These use the default configuration (`root/conf.yaml`) and default SSL certificates (`root/vertx.jks`). To use something else, you must rebuild the executable with your new files.

Some things can be configured with CLI arguments without needing to rebuild the executable. See `./ibkr-gateway --help`.

## Note

I have limited Java expertise and developed this to address a personal use case. Suggestions from people familiar with this ecosystem are appreciated. That said, it's been very reliable for me.

## Running the executable

Run the binary with the same JVM arguments that are used for the original application (`bin/run.sh`):

```sh
./ibkr-gateway                                                                               \
    -Dvertx.disableDnsResolver=true                                                          \
    -Djava.net.preferIPv4Stack=true                                                          \
    -Dvertx.logger-delegate-factory-class-name=io.vertx.core.logging.SLF4JLogDelegateFactory \
    -Dnologback.statusListenerClass=ch.qos.logback.core.status.OnConsoleStatusListener       \
    -Dnolog4j.debug=true                                                                     \
    -Dnolog4j2.debug=true
```

For HTTPS to work, `vertx.jks` must be in the same directory as the executable.

## Building the executable

### 1. Prepare the environment

```sh
scripts/prepare.sh
```

Then replace `conf.yaml` and `vertx.jks` in the root directory with your custom files.

### 2. Generate reachability metadata

```sh
scripts/gen-reachability.sh
```

Then login, make some requests, and stop the process. This collects dynamically accessed information so it can be included at build time. [Read more](https://www.graalvm.org/latest/reference-manual/native-image/metadata)

You probably don't need to do this as this file is already available in the `META-INF/native-image` directory, but it might need to be updated if the source code changes or you encounter reflection errors.

### 3. Build the executable

```sh
scripts/build.ts
```

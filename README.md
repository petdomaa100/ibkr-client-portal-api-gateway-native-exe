# IBKR Client Portal API Native Executable

Dynamically linked native executables for Linux, MacOS, and Windows are available in the [repository's releases](https://github.com/petdomaa100/ibkr-client-portal-api-gateway-native-exe/releases).

These executables use the default configuration (`root/conf.yaml`) and default SSL certificates (`root/vertx.jks`). To use something else, you must rebuild the executable with your new files. (This is because the IBKR devs decided to read files as streams from the classpath/resource path.)

Read more: https://www.graalvm.org/21.3/reference-manual/native-image/Resources/

Some things can be configured as CLI arguments without needing to rebuild the executable. See `./ibkr-gateway --help`.

## Running the executable

Execute using the same JVM arguments that are used for the original application (`bin/run.sh`):

```bash
./ibkr-gateway \
    -Dvertx.disableDnsResolver=true \
    -Djava.net.preferIPv4Stack=true \
    -Dvertx.logger-delegate-factory-class-name=io.vertx.core.logging.SLF4JLogDelegateFactory \
    -Dnologback.statusListenerClass=ch.qos.logback.core.status.OnConsoleStatusListener \
    -Dnolog4j.debug=true \
    -Dnolog4j2.debug=true
```

**Important:** For HTTPS to work, `vertx.jks` must be in the same directory as the executable.

## Building the executable yourself

### 1. Prepare the Environment

Run:

```bash
scripts/prepare.sh
```

Then replace `conf.yaml` and `vertx.jks` in the root directory with your custom files.

### 2. Generate Reachability Metadata

Run:

```bash
scripts/gen-reachability.sh
```

Then login, make some requests, and stop the process. This collects dynamically accessed information so it can be included at build time. Read more: https://www.graalvm.org/jdk21/reference-manual/native-image/metadata

You probably don't need to do this as this file is already available in the `META-INF/native-image` directory, but if the source code changes or you encounter reflection errors, you might need to update it.

### 3. Build the Executable

Run:

```bash
scripts/build.ts
```

For optimization levels, read: https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/

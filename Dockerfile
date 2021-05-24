FROM jenkins/agent:latest-buster-jdk11
USER root

# Updating the packages to the newest release.
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y -qq && apt-get dist-upgrade -y -qq && rm -rf /var/lib/apt/lists/

# Install base addon packages defined below.
ENV packages="git zip maven"
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y -qq && apt-get install -y -qq $packages && rm -rf /var/lib/apt/lists/*

# Install dependencies needed for https://github.com/cbdevnet/midimonster build.
ENV midimonster_dependencies_build="libasound2-dev libevdev-dev liblua5.3-dev libola-dev libjack-jackd2-dev python3-dev libssl-dev build-essential pkg-config mingw-w64 git-buildpackage"
ENV midimonster_dependencies_test="lintian codespell python3 python3-pip shellcheck cloc"
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -qq $midimonster_dependencies_build $midimonster_dependencies_test && rm -rf /var/lib/apt/lists/*

# Set user back to Jenkins like in the base image.
USER jenkins
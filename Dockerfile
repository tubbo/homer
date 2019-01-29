#
# Docker image that comes with Homer pre-installed. This is used for
# "integration" tests of the installer script to make sure it will
# automatically install everything correctly without having to blow away
# an existing install on a machine.
#

# Use the latest version of Ubuntu
FROM ubuntu:latest

# Build dependencies
RUN apt-get update -qq && apt-get install build-essential sudo curl zsh -yy

# Install Homer
COPY docs/install.sh install.sh
RUN bash install.sh

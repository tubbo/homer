#
# Docker image that comes with Homer pre-installed. This is used for
# "integration" tests of the installer script to make sure it will
# automatically install everything correctly without having to blow away
# an existing install on a machine.
#

# Install an operating system
FROM ubuntu:latest

# Install cURL
RUN apt-get update -qq && apt-get install curl -yy

# Install Homer with the one-liner script
COPY ../../docs/install.sh install.sh
RUN ./install.sh

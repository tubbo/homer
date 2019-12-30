#
# Docker image that comes with Homer pre-installed. This is used for
# "integration" tests of the installer script to make sure it will
# automatically install everything correctly without having to blow away
# an existing install on a machine.
#

# Use the latest version of Ubuntu
FROM ubuntu:latest

# Build dependencies
RUN apt-get update -qq && apt-get install build-essential sudo curl zsh git -yy

# Ensure the $PATH has /usr/local at the beginning
ENV PATH=/usr/local/bin:$PATH PREFIX=/usr/local

# Configure Git
RUN git config --global user.email "test@example.com"
RUN git config --global user.name "Lester Tester"

# Install Homer
COPY docs/install.sh install.sh
RUN bash install.sh

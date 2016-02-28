FROM java:openjdk-8-jre
MAINTAINER Tim Dudgeon <tdudgeon@informaticsmatters.com>

# only the latest version is downloadable so we cache versions locally
# download from http://www.farma.ku.dk/smartcyp/download.php
COPY versions/smartcyp-2.4.2.jar smartcyp.jar



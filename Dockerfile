FROM java:openjdk-8-jre
MAINTAINER Tim Dudgeon <tdudgeon@informaticsmatters.com>

RUN curl -L 'http://www.farma.ku.dk/smartcyp/smartcyp.jar' -o smartcyp.jar


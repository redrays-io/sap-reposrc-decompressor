# === Usage ===
# Download this Dockerfile, then:
# > docker build -t sap-reposrc-dec .
# > alias sap-reposrc-dec='docker run --rm -v `pwd`:/work -w /work sap-reposrc-dec'
# > sap-reposrc-dec <infile> <outfile> [-u] [-n]

FROM ubuntu:latest

ARG DEBIAN_FRONTEND="noninteractive"
ENV LANG="C.UTF-8" LC_ALL="C.UTF-8"

RUN apt-get -qq update && apt-get -qq upgrade
RUN apt-get -qq install git g++ make

WORKDIR /tmp
RUN git clone -q https://gitlab.com/daberlin/sap-reposrc-decompressor.git .

WORKDIR SAP-Report-Source-Decompressor
RUN make && make test
RUN ln sap-reposrc-decompressor /usr/local/bin

ENTRYPOINT ["sap-reposrc-decompressor"]

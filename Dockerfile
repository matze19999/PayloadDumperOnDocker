FROM debian:latest

# Geschrieben von
# Matthias Pröll <proell.matthias@gmail.com>
# Staudigl-Druck GmbH & Co. KG
# Letzte Anpassung: 2019/09/27

# LABELS
LABEL vendor="Staudigl-Druck GmbH & Co. KG"
LABEL maintainer="Matthias Pröll (proell.matthias@gmail.com)"
LABEL release-date="2019-09-17"

COPY . /payload_dumper

RUN apt update

RUN apt install --no-install-recommends -y python python-lzma python-dev python-pip

RUN apt-get clean

RUN pip install protobuf six backports.weakref

RUN chmod +x "/payload_dumper/update_metadata_pb2.py"
RUN chmod +x "/payload_dumper/payload_dumper.py"

WORKDIR "/payload_dumper"

CMD ["/usr/bin/python", "payload_dumper.py", "payload.bin"]

#docker run \
#-v /Docker/fileserver/files/payload:/payload_dumper/output \
#-v /Docker/fileserver/files/payload.bin:/payload_dumper/payload.bin \
#--name=payload_dumper \
#--privileged \
#payload_dumper:latest

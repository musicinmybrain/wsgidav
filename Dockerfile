# Dockerfile for https://github.com/mar10/wsgidav/
# Build:
#   docker build --rm -f Dockerfile -t mar10/wsgidav .
# Run:
#   docker run --rm -it -p <PORT>:8080 -v <ROOT_FOLDER>:/var/wsgidav-root mar10/wsgidav
# for example
#   docker run --rm -it -p 8080:8080 -v c:/temp:/var/wsgidav-root mar10/wsgidav
# Then open (or enter this URL in Windows File Explorer or any other WebDAV client)
#   http://localhost:8080/

# NOTE 2018-07-28: alpine does not compile lxml
# NOTE 2019-11-27: smallest image generated at the end
FROM python:3-alpine

#dependencies
RUN apk add --no-cache --virtual .build-deps gcc libxslt-dev musl-dev py3-lxml py3-pip \
    && pip install wsgidav cheroot lxml \
    && apk del .build-deps gcc musl-dev

RUN pip install --no-cache-dir wsgidav cheroot lxml
RUN mkdir -p /var/wsgidav-root

EXPOSE 8080

# Define the command to run WsgiDAV
CMD ["wsgidav", "--host=0.0.0.0", "--port=8080", "--root=/var/wsgidav-root", "--auth=anonymous", "--no-config"]

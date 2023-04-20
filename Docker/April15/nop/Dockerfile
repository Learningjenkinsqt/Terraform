FROM node:19-alpine
LABEL author="Prakash Reddy" organization="qualitythought"
RUN apk update \
    && apk add npm \
    && apk add git \ 
    && git clone https://github.com/expressjs/express \
    && cd express \
    && npm install express \
    && npm install -
    g express-generator@4 \
    && express /tmp/foo && cd /tmp/foo \
    && npm install
EXPOSE 3000
WORKDIR /tmp/foo
ENV ASPNETCORE_URLS="http://localhost:3000"
CMD [ "npm", "start" ]

FROM node:alpine3.20

WORKDIR /tmp

COPY . .

# 列出文件，检查index.js是否被复制
RUN ls -la

EXPOSE 3000/tcp

RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils &&\
    apk add --no-cache bash &&\
    chmod +x index.js &&\
    npm install

CMD ["node", "index.js"]

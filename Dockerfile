FROM node:alpine3.20

WORKDIR /app

COPY . .

RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

RUN chmod +x /app/index.js

# ----------------------------------------
# 创建 Choreo 合规用户 (UID 10014, GID 10014)
# ----------------------------------------
RUN addgroup -g 10014 appgroup && \
    adduser -D -u 10014 -G appgroup appuser

# 修复权限
RUN chown -R appuser:appgroup /app

# 切换到合规用户
USER 10014

EXPOSE 3000/tcp

CMD ["node", "index.js"]

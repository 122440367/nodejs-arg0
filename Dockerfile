FROM node:alpine3.20

WORKDIR /app

# 复制文件
COPY . .

# 安装依赖
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash && \
    npm install

# 给 index.js 权限（root 执行）
RUN chmod +x /app/index.js

# ----------------------------
# 创建一个非 root 用户
# ----------------------------
RUN addgroup -g 1001 appgroup && \
    adduser -D -u 1001 -G appgroup appuser

# 改变文件归属，让 appuser 能正常访问
RUN chown -R appuser:appgroup /app

# 切换到非 root 用户
USER appuser

EXPOSE 3000/tcp

CMD ["node", "index.js"]

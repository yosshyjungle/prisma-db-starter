# Next.js アプリ開発用イメージ（MySQL は docker-compose で起動）。
# 例: docker compose up -d mysql のあと、このイメージで依存インストール・dev 実行
FROM node:22-bookworm-slim

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends openssl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

RUN npx prisma generate

EXPOSE 3000

ENV NODE_ENV=development
CMD ["npm", "run", "dev", "--", "--hostname", "0.0.0.0", "--port", "3000"]

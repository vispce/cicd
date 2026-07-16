from node:20-alpine
workdir /app
copy package*.json ./
run npm install --production
copy server.js ./
cmd ["node", "server.js"]


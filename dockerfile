# Build the frontend [dist folder]
# Copy the dist  folder content in Backend/public folder

FROM node:20-alpine as frontend-builder

COPY ./Frontend /app
WORKDIR /app
RUN npm install

RUN npm run build

# Build the backend
FROM node:20-alpine
COPY ./Backend /app
WORKDIR /app
RUN npm install
# Copy the dist folder from frontend-builder to backend public folder
COPY --from=frontend-builder /app/dist /app/public

CMD ["node", "server.js"]
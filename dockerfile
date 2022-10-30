FROM node:10-alpine
COPY nodeapp /nodeapp
WORKDIR /nodeapp
RUN npm install
COPY --chown=node:node . .
EXPOSE 3000
CMD [ "node", "app.js" ]

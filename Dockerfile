FROM node:14
#ARG var_name
#ENV DATABASE_URL=${var_name}

# Create app directory
RUN mkdir /home/node/app
WORKDIR /home/node/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json /home/node/app/
COPY prisma /home/node/app/prisma/

# Install app dependencies
RUN npm install

# generate prisma client
RUN npx prisma db pull --force
RUN npx prisma generate

COPY . /image/home/node/app

EXPOSE 5555
CMD [ "npx", "prisma", "studio" ]

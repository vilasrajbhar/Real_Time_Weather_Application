# Use official node image as the base image
FROM node:18.15.0-alpine as dependencies

# Set the working directory
WORKDIR /usr/local/app
RUN mkdir Real_Time_Weather_Application
RUN ls -la
# Add the source code to app
COPY --chown=node:node . /usr/local/app/Real_Time_Weather_Application/

#Clearing Cache 
WORKDIR /usr/local/app/Real_Time_Weather_Application
RUN ls -la
RUN npm cache clean --force
RUN npm install
RUN npm run build
RUN ls -la
COPY startup.sh build/

## Creating new image
FROM node:18.15.0-alpine
WORKDIR /usr/local/app/
COPY --from=dependencies /usr/local/app/Real_Time_Weather_Application/build/ .
RUN ls -la

ENV PORT=8080
EXPOSE 8080

# check dist SaudiaWebApp
RUN ls -la /usr/local/app
RUN ["chmod", "+x", "/usr/local/app/startup.sh"]
ENTRYPOINT ["sh","/usr/local/app/startup.sh"]
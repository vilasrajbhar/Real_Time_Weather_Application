# Use official node image as the base image
FROM node:18.15.0-alpine as dependencies

# Set the working directory
WORKDIR /usr/local/app
RUN mkdir weather_forecast

# Add the source code to app
COPY --chown=node:node . /usr/local/app/weather_forecast/

#Clearing Cache 
WORKDIR /usr/local/app/weather_forecast
RUN rm -rf package-lock.json Dockerfile .gitignore dockerignore README.md .git
RUN ls -la
# npm clear cache and install package
RUN npm cache clean --force && npm install && npx update-browserslist-db@latest

# Assign port number
ENV PORT=8080
EXPOSE 8080

# check weather_forecast folder
RUN ls -la /usr/local/app/weather_forecast
RUN ["chmod", "+x", "/usr/local/app/weather_forecast/startup.sh"]

# execute startup.sh file
ENTRYPOINT ["sh","/usr/local/app/weather_forecast/startup.sh"]
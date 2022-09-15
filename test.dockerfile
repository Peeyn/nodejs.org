FROM build-dockerfile-1:latest
WORKDIR /nodejs.org/
RUN npm run test

# 1.
# The base image we want to use to build our docker image from.
# This image is specialised for golang.
# Therefore GOPATH will be set to /go
FROM golang:latest

# 2.
# Work Space Directory
WORKDIR /go/bin

# 3.
# Copy files and folders 
# from the local system 
# onto the docker image.
ADD . /go/src/docker-volume

# 4.
# Create an executable binary for our project 
# with the command "go install"
RUN go install docker-volume

# 5.
# The environment variable NAME
# will be picked up by the program 'docker-volume'
# and printed to the console.
ENV NAME Keir

# 6.
# ENTRYPOINT ["executable", "param1", "param2"] # exec-form
# ENTRYPOINT command param1 param2              # shell form
# The command to execute,
# when the container is started.
ENTRYPOINT ["/go/bin/docker-volume"]
# ENTRYPOINT "/go/bin/docker-volume"

# The CMD instruction if ENTRYPOINT is present in the Dockerfile 
# will act as default arguments 
# for the command represented by the ENTRYPOINT. 
# 
# But, these parameters can be overwritten 
# by providing arguments in the docker run <image> param1 param2 
# 
# 💡 The default ENTRYPOINT value can be overwritten in the Dockerfile 
# using the --entrypoint flag with the docker run command, 
# but it will only accept the executable value.
# 
# By using ENRTYPOINT instruction, the container acts as an executable, 
# which runs a command represented by the ENRTYPOINT 
# once it spawned using the docker run command. 
# Optional arguments may be passed to the docker run <image> [params] command,
# which replaces CMD values.

CMD [ "0" ]
# 7.
# Generally used for network applications.
# Allows us to connect to the application
# running inside the container
# from the host system's localhost.
EXPOSE 9000

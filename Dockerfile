# 1.
# The base image we want to use 
# to build our docker image from.
# This image is specialised for golang.
# Therefore GOPATH will be set to /go
FROM golang:latest

# 2.
# Work Space Directory
WORKDIR /go

# 3.
# Copy files and folders 
# from the local system 
# onto the docker image.
# ADD . /go/src/docker-volume
COPY . .

# 4.
# Create an executable binary for our project 
# with the command "go install"
RUN go build -o ./bin/docker-volume .

# create volume
VOLUME [  "/go/shared" ]

# 6.
# ENTRYPOINT ["executable", "param1", "param2"] # exec-form
# ENTRYPOINT command param1 param2              # shell-form
# The command to execute,
# when the container is started.
# exec-form ...
ENTRYPOINT [ "/go/bin/docker-volume" ] 
# ENTRYPOINT [ "/go/bin/docker-volume","3" ] 
# shell-form ...
# ENTRYPOINT "/go/bin/docker-volume" 

# The CMD-instruction 
# - if ENTRYPOINT is present in the Dockerfile -
# will act as default argument
# for the command represented by the ENTRYPOINT. 
# 
# But, these parameters can be overwritten 
# by providing arguments 
# in the docker run <image> param1 param2 
# 
# The default ENTRYPOINT value 
# can be overwritten in the Dockerfile 
# using the --entrypoint flag 
# with the docker run command, 
# but it will only accept the executable value.
# 
# By using the ENRTYPOINT instruction, 
# the container acts as an executable, 
# which runs a command represented by the ENRTYPOINT 
# once it is spawned 
# using the docker run command. 
# Optional arguments 
# may be passed to the docker run <image> [params] 
# command, which replaces CMD values.

# Default arguments
CMD [ "1" ]

#Obviously, can be updated to other golang versions
FROM golang:1.15.6-alpine AS dev

WORKDIR /src

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

#copy everything from /src into the build image
COPY /src .
RUN go mod download

#---------------

FROM dev as builder

#build the application to "/out/app"
RUN go build -o /out/app .

#---------------

#new, empty image (used by build scripts, for the final target image to name and save)
FROM scratch AS prod

#copy JUST the final application into the base directory
COPY --from=builder /out/app /

EXPOSE 3000:3000

#run the application on container start
CMD [ "/app" ]
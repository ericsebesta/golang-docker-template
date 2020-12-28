#Obviously, can be updated to other golang versions
FROM golang:1.15.6-alpine AS dev

WORKDIR /src

#copy everything from /src into the build image
COPY /src .

#---------------

FROM dev as builder

#build the application to "/out/app"
RUN go build -o /out/app .

#---------------

#new, empty image (used by build scripts, for the final target image to name and save)
FROM scratch AS prod

#copy JUST the final application into the base directory
COPY --from=builder /out/app /

#run the application on container start
CMD [ "/app" ]
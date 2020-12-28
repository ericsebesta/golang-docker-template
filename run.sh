docker container rm -f golang-docker-template-prod
docker run -dp 3000:3000 --name golang-docker-template-prod golang-docker-template:prod

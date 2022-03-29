#Container image that runs your code
FROM rocker/r-base

RUN Rscript -e "install.packages(c('rmarkdown','bookdown','pacman'))"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh render.R /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

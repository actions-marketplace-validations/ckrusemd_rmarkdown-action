#Container image that runs your code
FROM rocker/r-base

RUN wget https://github.com/jgm/pandoc/releases/download/2.17.1.1/pandoc-2.17.1.1-1-amd64.deb -P ~/pandoc-2.17.1.1-1-amd64.deb

RUN dpkg -i ~/pandoc-2.17.1.1-1-amd64.deb

RUN Rscript -e "install.packages(c('rmarkdown','bookdown','pacman'))"
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh render.R /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

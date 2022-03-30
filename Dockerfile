#Container image that runs your code
FROM rocker/r-base

RUN TEMP_DEB="$(mktemp)" && wget -O "$TEMP_DEB" 'https://github.com/jgm/pandoc/releases/download/2.17.1.1/pandoc-2.17.1.1-1-amd64.deb' && dpkg -i "$TEMP_DEB" && rm -f "$TEMP_DEB"
RUN apt-get update && apt-get -y install xml2 openssl libxml2 libxml2-dev libmariadb-dev libcurl4-gnutls-dev
RUN echo FRED_API=${{ secrets.FRED_API }} >> Renviron.site
RUN Rscript -e "install.packages(c('rmarkdown','bookdown','pacman'))"
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh render.R /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

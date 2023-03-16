#Container image that runs your code
FROM rocker/r-base

RUN TEMP_DEB="$(mktemp)" && wget -O "$TEMP_DEB" 'https://github.com/jgm/pandoc/releases/download/3.1.1/pandoc-3.1.1-1-amd64.deb' && dpkg -i "$TEMP_DEB" && rm -f "$TEMP_DEB"
RUN apt-get update && apt-get -y install xml2 openssl libxml2 libxml2-dev libmariadb-dev libcurl4-gnutls-dev
#RUN echo FRED_API=${{ secrets.FRED_API }} >> Renviron.site
#RUN R CMD javareconf
RUN Rscript -e "install.packages(c('units'));install.packages(c('sf'));install.packages(c('pacman','transformr','devtools'));library(devtools);install_github('rOpenGov/dkstat')"
RUN Rscript -e "library(pacman);pacman::p_load(XML,progress,openxlsx,readr,DT,DBI,RSQLite,stringr,xgboost,quantmod,earth,ecb,gam,TTR,igraph,randomForest,boot,forcats,broom,glue,dkstat,rPref,RCurl,epibasix,png,openxlsx,tibbletime,tibble,drc,Ryacas,directlabels,ISOweek,rmarkdown,bookdown,pacman,tidyr,dplyr,ggplot2,httr,rvest,openxlsx,zoo,PlayerRatings,caret,partykit,pROC,gganimate,devtools,scales,fredr)"
#RUN Rscript -e "install.packages(c('rmarkdown','bookdown','pacman','tidyr','dplyr','ggplot2','httr','rvest','openxlsx','zoo','PlayerRatings','caret','partykit','pROC','gganimate','devtools','scales','fredr'))"
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh render.R /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
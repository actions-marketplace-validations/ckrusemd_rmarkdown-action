#Container image that runs your code
FROM ckrusemd/bookdown-action

COPY entrypoint.sh render.R /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

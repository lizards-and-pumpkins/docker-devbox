#!/bin/bash

# $PORT and $BASE_URL need to be ENV Variables passed to "docker run"
if [ $PORT = 80 ]
  then
    export LP_BASE_URL_FR="${PROTO}://${BASE_URL}/fr/"
    export LP_BASE_URL_DE="${PROTO}://${BASE_URL}/de/"
    export LP_BASE_URL_EN="${PROTO}://${BASE_URL}/en/"
  else
    export LP_BASE_URL_FR="${PROTO}://${BASE_URL}:${PORT}/fr/"
    export LP_BASE_URL_DE="${PROTO}://${BASE_URL}:${PORT}/de/"
    export LP_BASE_URL_EN="${PROTO}://${BASE_URL}:${PORT}/en/"
fi

export LP_FILE_STORAGE_BASE_PATH="/var/www/file-storage"
export LP_BASE_URL_TO_WEBSITE_MAP="${PROTO}://${BASE_URL}:${PORT}/en/=en|${PROTO}://${BASE_URL}:${PORT}/fr/=fr|${PROTO}://${BASE_URL}:${PORT}/de/=de|${PROTO}://${BASE_URL}/en/=en|${PROTO}://${BASE_URL}/fr/=fr|${PROTO}://${BASE_URL}/de/=de|${PROTO}://${BASE_URL}/=en|${PROTO}://${BASE_URL}:${PORT}/=en"
export LP_LOG_FILE_PATH="/var/www/lizards/var/log/system.log"
export LP_MEDIA_BASE_PATH="/var/www/lizards/pub/media"

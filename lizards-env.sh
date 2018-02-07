#!/bin/bash

# $PORT and $BASE_URL need to be ENV Variables passed to "docker run"
if [ $PORT = 80 ]
  then
    export LP_BASE_URL_FR="http://${BASE_URL}/fr/"
    export LP_BASE_URL_DE="http://${BASE_URL}/de/"
    export LP_BASE_URL_EN="http://${BASE_URL}/en/"
  else
    export LP_BASE_URL_FR="http://${BASE_URL}:${PORT}/fr/"
    export LP_BASE_URL_DE="http://${BASE_URL}:${PORT}/de/"
    export LP_BASE_URL_EN="http://${BASE_URL}:${PORT}/en/"
fi

export LP_FILE_STORAGE_BASE_PATH="/var/www/file-storage"
export LP_BASE_URL_TO_WEBSITE_MAP="http://${BASE_URL}:${PORT}/en/=en|http://${BASE_URL}:${PORT}/fr/=fr|http://${BASE_URL}:${PORT}/de/=de|http://${BASE_URL}/en/=en|http://${BASE_URL}/fr/=fr|http://${BASE_URL}/de/=de|http://${BASE_URL}/=en|http://${BASE_URL}::${PORT}/=en"
export LP_LOG_FILE_PATH="/var/www/lizards/var/log/system.log"
export LP_MEDIA_BASE_PATH="/var/www/lizards/pub/media"

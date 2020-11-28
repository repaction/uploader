#!/bin/sh

CURL_BIN=$(which curl)
CURL_PARAMETERS="-k -L -s -g -i"
API_UPLOAD_URL="https://content.dropboxapi.com/2/files/upload"

RESPONSE_FILE="/tmp/du_resp_$RANDOM"
ERROR_STATUS=0

# File upload with curl
function db_upload_file
{
    local FILE_SRC="$1"
    local FILE_DST="$2"
    
    echo " > Uploading \"$FILE_SRC\" to \"$FILE_DST\"..."
    $CURL_BIN -o "$RESPONSE_FILE" $CURL_PARAMETERS -X POST \
	      --header "Authorization: Bearer $DROPBOX_TOKEN" \
	      --header "Dropbox-API-Arg: {\"path\": \"$FILE_DST\",\"mode\": \"overwrite\",\"autorename\": false,\"mute\": false}" \
	      --header "Content-Type: application/octet-stream" \
	      --data-binary @"$FILE_SRC" "$API_UPLOAD_URL"

    ERROR_STATUS=$?
    
    #Check
    if grep -q "^HTTP/[12].* 200" "$RESPONSE_FILE"; then
        echo "DONE"
    else
        echo "::error::FAILED: An error occurred requesting /upload."
    fi
}

db_upload_file $1 $2

exit $ERROR_STATUS

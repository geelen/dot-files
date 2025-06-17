#!/bin/sh
INITIAL_WORKING_DIRECTORY=$(pwd);
cd "$(dirname $0)";

touch ./NPM_TOKEN.env;
source ./NPM_TOKEN.env;

exp=$(echo $NPM_TOKEN | jq -R 'split(".") | .[1] | @base64d | fromjson | .exp' 2>/dev/null);

function update_NPM_TOKEN() {
  NPM_TOKEN=$(cloudflared access login https://registry.cloudflare-ui.com 2>/dev/null | grep ey);
  if [[ ! -z "$NPM_TOKEN" ]]; then
    echo "NPM_TOKEN=${NPM_TOKEN}" > ./NPM_TOKEN.env;
    echo "NPM token updated.";
  else
    echo "Unable to update NPM token.";
  fi

  source ./NPM_TOKEN.env;
}

if [[ -z "$exp" ]]; then
  echo "NPM token is missing."
  update_NPM_TOKEN;
elif [[ "$exp" -le "$(date +%s)" ]]; then
  echo "NPM token has expired."
  update_NPM_TOKEN;
fi

cd $INITIAL_WORKING_DIRECTORY;


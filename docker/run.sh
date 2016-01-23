#!/bin/sh

set -e

envtpl --keep-template /etc/nginx/nginx.conf.tpl

if [ ! -z "${BLOPF_BASIC_AUTH_LOGIN}" ]; then
    echo "${BLOPF_BASIC_AUTH_LOGIN}:${BLOPF_BASIC_AUTH_PASSWORD}" > /etc/nginx/blopf.htpasswd
fi

BLOPF_REFRESH_RATE="${BLOPF_REFRESH_RATE:-5000}"
BLOPF_THEME="${BLOPF_THEME:-dark}"
BLOPF_WITH_CREDENTIALS="${BLOPF_WITH_CREDENTIALS:-false}"

cat <<EOF > /blopf/_site/blopf_external_settings.json
{
    "elasticsearch_root_path": "/es",
    "with_credentials": ${BLOPF_WITH_CREDENTIALS},
    "theme": "${BLOPF_THEME}",
    "refresh_rate": ${BLOPF_REFRESH_RATE}
}
EOF

exec nginx

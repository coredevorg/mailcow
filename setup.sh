#!/usr/bin/env bash
./generate_config.sh
source .env
DOMAIN=${MAILCOW_HOSTNAME#*.}
echo "AUTODISCOVER=autodiscover.$DOMAIN,autoconfig.$DOMAIN" >> .env
echo "XMPP_HOSTNAME=im.$DOMAIN" >> .env
$NGINX_PROXY_PATH/checkhost.sh $MAILCOW_HOSTNAME
echo "login with [admin:moohoo] to continue configuration after startup!"
echo -n "continue with startup? " && read dummy
docker-compose -f docker-compose.yml up -d --build
echo -n "show startup logs? " && read dummy
docker-compose -f docker-compose.yml logs -f --tail 1000

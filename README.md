# fb-chat-cli

With [gohyda/fb-chat-cli](https://hub.docker.com/r/gohyda/fb-chat-cli/) you can use Facebook chat from your terminal easily.

The CLI is a preconfigured [WeeChat](https://weechat.org/) client which is connect to Facebook through [BitlBee](https://www.bitlbee.org/) IRC gateway.

### Usage
```sh
docker run -ti --rm \
    -e USERNAME="facebook_username" \
    -e PASSWORD="facebook_password" \
    gohyda/fb-chat-cli
```

### Screenshot
![screenshot](https://raw.githubusercontent.com/gohyda/fb-chat-cli/master/screenshot.png)

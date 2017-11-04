# fb-chat-cli

With [gohyda/fb-chat-cli](https://hub.docker.com/r/gohyda/fb-chat-cli/) you can use Facebook chat from your terminal easily.

The CLI is a preconfigured IRC client ([WeeChat](https://weechat.org/)) which is connect to Facebook through an IRC gateway ([BitlBee](https://www.bitlbee.org/)).

### Usage
```sh
docker run -ti --rm \
    -e USERNAME="facebook_username" \
    -e PASSWORD="facebook_password" \
    gohyda/fb-chat-cli
```

### Screenshot
![screenshot](https://raw.githubusercontent.com/gohyda/fb-chat-cli/master/screenshot.png)

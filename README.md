# fb-chat-cli

With [bszigeti/fb-chat-cli](https://hub.docker.com/r/bszigeti/fb-chat-cli/) you can use Facebook chat from your terminal easily.

The CLI is a preconfigured IRC client ([WeeChat](https://weechat.org/)) which is connect to Facebook through an IRC gateway ([BitlBee](https://www.bitlbee.org/)).

### Usage
```sh
docker run -ti --rm \
    -e FB_USERNAME="facebook_username" \
    -e FB_PASSWORD="facebook_password" \
    -e IRC_NICK="nick" \
    bszigeti/fb-chat-cli
```

### Screenshot
![screenshot](https://raw.githubusercontent.com/bszigeti/fb-chat-cli/master/screenshot.png)

FROM alpine:edge
MAINTAINER Bence SZIGETI <bence.szigeti@gohyda.com>

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> \
    /etc/apk/repositories
RUN apk add --update-cache --no-cache \
    bitlbee \
    bitlbee-facebook \
    python \
    weechat \
    weechat-perl \
    weechat-python

ARG USERNAME=user
RUN addgroup ${USERNAME} \
    && adduser -D -s /sbin/nologin -G ${USERNAME} ${USERNAME}
ENV HOME /home/${USERNAME}
WORKDIR ${HOME}
ADD entrypoint.sh ${HOME}/
RUN chmod +x ${HOME}/entrypoint.sh
RUN chown -R ${USERNAME}:${USERNAME} ${HOME}/

RUN chown -R ${USERNAME}:${USERNAME} /var/lib/bitlbee/
RUN rm /etc/bitlbee/motd.txt

USER ${USERNAME}
ENTRYPOINT ["./entrypoint.sh"]

#!/bin/sh

check_env_var() {
    local VALUE="$1"
    local ERROR_MSG="$2"
    if [ -z "${VALUE}" ]; then
        echo "${ERROR_MSG}";
        exit 1;
    fi;
}

check_env_var "${FULL_NAME}" 'USERNAME is missing.'
check_env_var "${EMAIL}" 'PASSWORD is missing.'

# Start BitlBee server
bitlbee -F

CMDS=""

add_cmd() {
    local CMD=${1}
    CMDS="${CMDS}${CMD};"
}

# Plugins
add_cmd "/plugin load alias"
add_cmd "/plugin load charset"
add_cmd "/plugin load irc"
add_cmd "/plugin load perl"
add_cmd "/plugin load python"
add_cmd "/plugin load trigger"
add_cmd "/plugin load buflist"

# Look
add_cmd "/buffer set short_name core"
add_cmd "/set weechat.look.window_title \"\""
add_cmd "/set irc.look.server_buffer independent"

# Mouse
add_cmd "/mouse enable"

# Disable flood protection
add_cmd "/set irc.server_default.anti_flood_prio_high 0"
add_cmd "/set irc.server_default.anti_flood_prio_low 0"

# Hardening
add_cmd "/set irc.server_default.msg_kick \"\""
add_cmd "/set irc.server_default.msg_part \"\""
add_cmd "/set irc.server_default.msg_quit \"\""
add_cmd "/set irc.ctcp.clientinfo \"\""
add_cmd "/set irc.ctcp.finger \"\""
add_cmd "/set irc.ctcp.source \"\""
add_cmd "/set irc.ctcp.time \"\""
add_cmd "/set irc.ctcp.userinfo \"\""
add_cmd "/set irc.ctcp.version \"\""
add_cmd "/set irc.ctcp.ping \"\""

# Nick
NICK=`echo ${USERNAME} | sed 's/[^0-9a-zA-Z_-]/_/g'`
add_cmd "/set irc.server_default.nicks ${NICK}"
add_cmd "/set irc.server_default.nicks_alternate off"

# Server
add_cmd "/server add facebook 127.0.0.1/6667"

# BitlBee
BITLBEE_CMDS=""

add_bitlbee_cmd() {
    local CMD=${1}
    BITLBEE_CMDS="${BITLBEE_CMDS}${CMD}\;"
}

add_bitlbee_msg_cmd() {
    local CMD=${1}
    add_bitlbee_cmd "/msg -server facebook &facebook ${CMD}"
}

add_bitlbee_cmd "/join -server facebook &facebook"
add_bitlbee_msg_cmd "set utf8_nicks on"
add_bitlbee_msg_cmd "chan &bitlbee set show_users \"\""
add_bitlbee_msg_cmd "chan &facebook set show_users online+,away+,offline"
add_bitlbee_msg_cmd "account add facebook ${USERNAME} ${PASSWORD}"
add_bitlbee_msg_cmd "account facebook set mark_read false"
add_bitlbee_msg_cmd "account facebook set mark_read_reply true"
add_bitlbee_msg_cmd "account facebook set show_unread true"
add_bitlbee_msg_cmd "account facebook set group_chat_open all"
add_bitlbee_msg_cmd "account facebook on"
add_bitlbee_cmd "/buffer clear irc.facebook.&facebook"
add_bitlbee_cmd "/buffer clear irc.server.facebook"

add_cmd "/set irc.server.facebook.command \"${BITLBEE_CMDS}\""

# Manual autoconnect
add_cmd "/connect facebook"

# Clean config-change logs
add_cmd "/buffer clear 1"

# Start WeeChat
exec weechat \
    --no-plugin \
    --no-script \
    --no-connect \
    --run-command "${CMDS}"

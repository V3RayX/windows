// ignore_for_file: unnecessary_brace_in_string_interps, unused_import
import 'dart:io';

String genConfig(
  String listenPortSocks,
  String listenPortHTTP,
  String serverAddress,
  String serverPort,
  String usersID,
  String serverProtocol,
  String requestHeaderHost,
) {
  /*
  *
  *
  *
  */
  String actualConfig = """
{
  "stats": {},
  "log": {
    "loglevel": "none"
  },
  "policy": {
    "levels": {
      "8": {
        "handshake": 4,
        "connIdle": 300,
        "uplinkOnly": 1,
        "downlinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "inbounds": [
    {
      "tag": "socks",
      "port": ${listenPortSocks},
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "tag": "http",
      "port": ${listenPortHTTP},
      "protocol": "http",
      "settings": {
        "userLevel": 8
      }
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "${serverProtocol}",
      "settings": {
        "vnext": [
          {
            "address": "${serverAddress}",
            "port": ${serverPort},
            "users": [
              {
                "id": "${usersID}",
                "alterId": 0,
                "security": "auto",
                "level": 8
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "header": {
            "type": "http",
            "request": {
              "headers": {
                "Host": [
                  "${requestHeaderHost}"
                ],
                "Accept-Encoding": [
                  "gzip, deflate"
                ],
                "Connection": [
                  "keep-alive"
                ],
                "Pragma": "no-cache",
                "User-Agent": [
                  "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36",
                  "Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_2 like Mac OS X) AppleWebKit/601.1 (KHTML, like Gecko) CriOS/53.0.2785.109 Mobile/14A456 Safari/601.1.46"
                ]
              },
              "method": "GET",
              "path": [
                "/"
              ],
              "version": "1.1"
            }
          }
        }
      },
      "mux": {
        "enabled": false
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "block",
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      }
    }
  ],
  "dns": {
    "servers": [
      "8.8.8.8"
    ]
  },
  "routing": {
    "domainStrategy": "Asls",
    "rules": []
  }
}
""";
  return actualConfig;
}

void generateConfigFile(String configFile, String configString) {}

// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proxy_manager/proxy_manager.dart';
import 'home.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// Variables used to generate config
String? confsocksListenOn;
String? confhttpListenOn;
String? confaddress;
String? confUserId;
String? confserverPort;
String? serverProtocol;
String? confhttpRequestHeader;

class ConnectScreenHome extends StatefulWidget {
  const ConnectScreenHome({super.key});

  @override
  State<ConnectScreenHome> createState() => _ConnectScreenHomeState();
}

class _ConnectScreenHomeState extends State<ConnectScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Hi'), ConnectButton()],
        ),
      )),
    );
  }
}

class ConnectButton extends StatefulWidget {
  const ConnectButton({super.key});

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

ProxyManager manager = ProxyManager();
void setSystemProxy(String? listenOn, int? port) async {
  if (port.isNull) {
    port = 10809;
  }
  if (listenOn == null) {
    listenOn = '127.0.0.1';
  }
  await manager.setAsSystemProxy(ProxyTypes.http, listenOn, port!);
}

class _ConnectButtonState extends State<ConnectButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        child: Text('Connect'),
        onPressed: () async {
          try {
            String corePath = await _localPath + '\\v3ray\\';
            final verb = 'open'.toNativeUtf16();
            final process = '${corePath}\\v2ray.exe'.toNativeUtf16();
            final params = ''.toNativeUtf16();
            final nullParams = ''.toNativeUtf16();
            ShellExecute(0, verb, process, params, nullParams, SW_SHOW);
          } catch (e) {
            // do something
          }
        },
      ),
    );
  }
}

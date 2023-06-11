// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';

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

class _ConnectButtonState extends State<ConnectButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        child: Text('Connect'),
        onPressed: () {
          try {
            final verb = 'open'.toNativeUtf16();
            final process = 'assets/v2rayCore/v2ray.exe'.toNativeUtf16();
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

// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'dart:convert';
import 'dart:io';

import 'main.dart';
import 'connect.dart';
import 'proxy/gen_config.dart';

bool configFieldShow = false;
String? configFieldText;
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path\\v3ray\\out\\config.json');
}

Future<File> writeConfig(String finalconfiguration) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(finalconfiguration);
}

Future<File> writeCoreZip(String path, bytes) async {
  final file_tmp = File(path);
  file_tmp.writeAsBytesSync(bytes);
  return file_tmp;
}

void CreateDirectory(String path, String name) async {
  String finalPath = path + '\\' + name;
  await Directory(finalPath).create();
}

String? finalConf;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AddConfigTextBox(), CompileRawConfig()],
        )),
      ),
    );
  }
}

TextEditingController? rawConfigTextBoxController;

class AddConfigTextBox extends StatefulWidget {
  const AddConfigTextBox({super.key});

  @override
  State<AddConfigTextBox> createState() => _AddConfigTextBoxState();
}

class _AddConfigTextBoxState extends State<AddConfigTextBox> {
  @override
  void initState() {
    super.initState();
    rawConfigTextBoxController = TextEditingController();
  }

  @override
  void dispose() {
    rawConfigTextBoxController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextField(
        controller: rawConfigTextBoxController,
        decoration: InputDecoration(
          labelText: 'V2Ray Config',
          hintText: 'Enter base64 v2ray config',
          errorMaxLines: 3,
          errorText: configFieldShow ? configFieldText : null,
        ),
        autofocus: true,
        autocorrect: false,
        maxLength: 1500,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    );
  }
}

class CompileRawConfig extends StatefulWidget {
  const CompileRawConfig({super.key});

  @override
  State<CompileRawConfig> createState() => _CompileRawConfigState();
}

class _CompileRawConfigState extends State<CompileRawConfig> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        child: Text('Go'),
        onPressed: () async {
          String? rawBase64;
          String? serverProtocol;
          if (rawConfigTextBoxController!.text.isEmpty != true) {
            if (rawConfigTextBoxController!.text.startsWith('vmess://')) {
              rawBase64 = rawConfigTextBoxController!.text.substring(8);
              serverProtocol = 'vmess';
            } else if (rawConfigTextBoxController!.text
                .startsWith('trojan://')) {
              rawBase64 = rawConfigTextBoxController!.text.substring(9);
              serverProtocol = 'trojan';
            }

            var rawDecodedBase64 = base64.decoder.convert(rawBase64!);
            var decodedBase64 = utf8.decode(rawDecodedBase64);
            var rawJson = jsonDecode(decodedBase64);
            //print(rawJson);
            finalConf = genConfig(
                listenPortSocks: '10808',
                listenPortHTTP: '10809',
                serverAddress: rawJson['add'],
                serverPort: rawJson['port'].toString(),
                usersID: rawJson['id'],
                serverProtocol: serverProtocol!,
                requestHeaderHost: rawJson['host'] ?? '');

            CreateDirectory(await _localPath, 'v3ray');
            String corePathTarget =
                await _localPath + '\\v3ray\\' + 'v2rayCore.zip';
            String dest = await _localPath + '\\v3ray\\';
            print(corePathTarget);
            final corezipfile = File('assets/v2rayCore.zip');
            final coreData = corezipfile.readAsBytesSync();
            writeCoreZip(corePathTarget, coreData);

            extractFileToDisk(corePathTarget, dest);

            // writeConfig(finalConf!);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ConnectScreenHome()),
            );
          } else {
            setState(() {
              configFieldShow = true;
              configFieldText = 'Config cannot be empty';
            });
          }
        },
      ),
    );
  }
}

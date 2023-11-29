import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:dls_permissions_handler/dls_permissions_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dlsPermissionsHandlerPlugin = DlsPermissionsHandler();

  Future<void> requestPermissions() async {
    final micResult = await _dlsPermissionsHandlerPlugin
        .checkPermission(DlsPermission.microphone);
    final camResult = await _dlsPermissionsHandlerPlugin
        .checkPermission(DlsPermission.camera);

    log('mic: $micResult; cam: $camResult');
  }

  void openSysPrefs() {
    _dlsPermissionsHandlerPlugin.openSysPrefs(DlsPermission.camera);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: requestPermissions,
              child: const Text('Check Permissions'),
            ),
            ElevatedButton(
              onPressed: openSysPrefs,
              child: const Text('Open SysPrefs'),
            ),
          ],
        )),
      ),
    );
  }
}

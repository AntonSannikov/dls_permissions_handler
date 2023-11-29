// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window, PermissionStatus;

import 'package:dls_permissions_handler/dls_permissions_handler.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'dls_permissions_handler_platform_interface.dart';

/// A web implementation of the DlsPermissionsHandlerPlatform of the DlsPermissionsHandler plugin.
class DlsPermissionsHandlerWeb extends DlsPermissionsHandlerPlatform {
  /// Constructs a DlsPermissionsHandlerWeb
  DlsPermissionsHandlerWeb();

  static void registerWith(Registrar registrar) {
    DlsPermissionsHandlerPlatform.instance = DlsPermissionsHandlerWeb();
  }

  @override
  Future<bool> checkPermission(DlsPermission permission) async {
    try {
      html.PermissionStatus? status;

      switch (permission) {
        case DlsPermission.camera:
          status = await html.window.navigator.permissions
              ?.query({'name': 'camera'});
        case DlsPermission.microphone:
          status = await html.window.navigator.permissions
              ?.query({'name': 'microphone'});
        default:
          return false;
      }

      return status?.state == 'granted';
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestPermission(DlsPermission permission) async {
    try {
      switch (permission) {
        case DlsPermission.all:
          await html.window.navigator.getUserMedia(audio: true, video: true);
        case DlsPermission.camera:
          await html.window.navigator.getUserMedia(video: true);
        case DlsPermission.microphone:
          await html.window.navigator.getUserMedia(audio: true);
      }

      return true;
    } catch (_) {
      return false;
    }
  }
}

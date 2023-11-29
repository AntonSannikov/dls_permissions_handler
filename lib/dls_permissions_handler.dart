// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:dls_permissions_handler/src/dls_permissions_handler_platform_interface.dart';

enum DlsPermission {
  microphone,
  camera,
  all,
}

class DlsPermissionsHandler {
  Future<bool> checkPermission(DlsPermission permission) {
    return DlsPermissionsHandlerPlatform.instance.checkPermission(permission);
  }

  /// Currently only allowed on Web
  Future<bool> requestPermission(DlsPermission permission) {
    return DlsPermissionsHandlerPlatform.instance.requestPermission(permission);
  }

  /// Currently only allowed on Mac
  void openSysPrefs(DlsPermission type) {
    DlsPermissionsHandlerPlatform.instance.openSysPrefs(type);
  }
}

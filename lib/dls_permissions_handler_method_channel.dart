import 'dart:developer';

import 'package:dls_permissions_handler/dls_permissions_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dls_permissions_handler_platform_interface.dart';

class MethodChannelDlsPermissionsHandler extends DlsPermissionsHandlerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('dls_permissions_handler');

  @override
  Future<bool> checkPermission(DlsPermission permission) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('checkPermission', {
        'type': permission.name,
      });

      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  void openSysPrefs(DlsPermission type) {
    try {
      methodChannel.invokeMethod<void>('openSysPrefs', {
        'type': type.name,
      });
    } catch (e, s) {
      log('[DlsPermissionsHandler]: openSysPrefs failure: $e\n$s');
    }
  }
}

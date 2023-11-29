import 'package:dls_permissions_handler/dls_permissions_handler.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dls_permissions_handler_method_channel.dart';

abstract class DlsPermissionsHandlerPlatform extends PlatformInterface {
  /// Constructs a DlsPermissionsHandlerPlatform.
  DlsPermissionsHandlerPlatform() : super(token: _token);

  static final Object _token = Object();

  static DlsPermissionsHandlerPlatform _instance =
      MethodChannelDlsPermissionsHandler();

  /// The default instance of [DlsPermissionsHandlerPlatform] to use.
  ///
  /// Defaults to [MethodChannelDlsPermissionsHandler].
  static DlsPermissionsHandlerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DlsPermissionsHandlerPlatform] when
  /// they register themselves.
  static set instance(DlsPermissionsHandlerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> checkPermission(DlsPermission permission) {
    throw UnimplementedError('checkPermission() has not been implemented.');
  }

  Future<bool> requestPermission(DlsPermission permission) {
    throw UnimplementedError('requestPermission() has not been implemented.');
  }

  void openSysPrefs(DlsPermission type) {
    throw UnimplementedError('openSysPrefs() has not been implemented.');
  }
}

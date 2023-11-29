import Cocoa
import FlutterMacOS
import AVFoundation
import AppKit

public class DlsPermissionsHandlerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "dls_permissions_handler", binaryMessenger: registrar.messenger)
        let instance = DlsPermissionsHandlerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "checkPermission":
            let args = call.arguments as! Dictionary<String, Any>
            let type = args["type"] as! String
            if (type == "camera") {
                checkCameraPermission({
                    success in
                    result(success)
                })
            } else if (type == "microphone") {
                checkMicrophonePermission({
                    success in
                    result(success)
                })
            }
        case "openSysPrefs":
            let args = call.arguments as! Dictionary<String, Any>
            let type = args["type"] as! String
            let prefsUrl = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_\(type.capitalized)")!
            NSWorkspace.shared.open(prefsUrl)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func checkCameraPermission(_ completion: @escaping (_ success: Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                completion(granted)
            })
        }
    }
    
    private func checkMicrophonePermission(_ completion: @escaping (_ success: Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .audio) ==  .authorized {
            completion(true)
        } else {
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (granted: Bool) in
                completion(granted)
            })
        }
        
    }
//    
//    private func showAlert(title: String, message: String, type: String, sysPrefsText: String, cancelBtnText: String)-> Void {
//        DispatchQueue.main.async {
//            self.alertToSettings(
//                title: title,
//                message: message,
//                sysPrefsText: sysPrefsText,
//                cancelBtnText: cancelBtnText,
//                {
//                    success in
//                    if (success) {
//                        
//                    }
//                }
//            )
//        }
//        
//    }
//    
//    private func alertToSettings(title: String, message: String, sysPrefsText: String, cancelBtnText: String, _ comletion: @escaping (_ success: Bool) -> Void) {
//        let alert = NSAlert()
//        alert.messageText = title
//        alert.informativeText = message
//        alert.alertStyle = NSAlert.Style.warning
//        alert.addButton(withTitle: sysPrefsText)
//        alert.addButton(withTitle: cancelBtnText)
//        comletion(alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn)
//    }
}

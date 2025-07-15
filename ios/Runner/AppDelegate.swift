import Flutter
import UIKit
import FaceLiveness
import AWSCognitoAuthPlugin
import Amplify
import SwiftUI

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "com.example.fcb_pay_plus/liveness"
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Amplify Setup
    do {
      try Amplify.add(plugin: AWSCognitoAuthPlugin())
      try Amplify.configure()
    } catch {
      print("Amplify failed to initialize: \(error)")
    }

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler{ call, result in
      if call.method == "startFaceLiveness", let args = call.arguments as? [String: Any],
         let sessionId = args["sessionId"] as? String,
         let region = args["region"] as? String {
        self.presentLiveness(sessionId: sessionId, region: region, flutterResult: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
   private func presentLiveness(sessionId: String, region: String, flutterResult: @escaping FlutterResult) {
    var hostingController: UIHostingController<FaceLivenessDetectorView>? = nil

    let livenessView = FaceLivenessDetectorView(
      sessionID: sessionId,
      region: region,
      isPresented: .constant(true),
      onCompletion: { result in
        DispatchQueue.main.async {
          if let host = hostingController {
            host.dismiss(animated: true)
          }

          switch result {
          case .success:
            flutterResult(["status": "complete", "message": "Liveness succeeded"])
          case .failure(let error):
            flutterResult(FlutterError(code: "LIVENESS_ERROR", message: error.localizedDescription, details: nil))
          @unknown default:
            flutterResult(FlutterMethodNotImplemented)
          }
        }
      }
    )

    hostingController = UIHostingController(rootView: livenessView)

    guard let root = window?.rootViewController,
          let controller = hostingController else {
      flutterResult(FlutterError(code: "NO_CONTROLLER", message: "Could not present liveness view", details: nil))
      return
    }

    DispatchQueue.main.async {
      root.present(controller, animated: true)
    }
  }
}

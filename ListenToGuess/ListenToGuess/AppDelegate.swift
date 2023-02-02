//
//  AppDelegate.swift
//  ListenToGuess
//
//  Created by on 2021/11/24.
//

import UIKit
import AppTrackingTransparency
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 14, *) {
            guard !UserDefaults.standard.bool(forKey: "IsFirstOpen") else { return true }
            UserDefaults.standard.set(true, forKey: "IsFirstOpen")
            let status = ATTrackingManager.trackingAuthorizationStatus
            switch status {
            case .authorized:
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .notDetermined:
                ATTrackingManager.requestTrackingAuthorization { (popStatus) in
                    DispatchQueue.main.async(execute: {
                        if popStatus == .authorized {
                            let mAlert = UIAlertController(
                                title: "通知",
                                message: "已点击同意追踪",
                                preferredStyle: .alert)
                            let action = UIAlertAction(title: "确认", style: .default) {
                                (action) in
                                mAlert.dismiss(animated: true, completion: nil)
                            }
                            mAlert.addAction(action)
                            self.window?.rootViewController?.present(mAlert, animated: true, completion: nil)
                        } else {
                            let mAlert = UIAlertController(
                                title: "通知",
                                message: "已点击不要追踪",
                                preferredStyle: .alert)
                            let action = UIAlertAction(title: "确认", style: .default) {
                                (action) in
                                mAlert.dismiss(animated: true, completion: nil)
                            }
                            let settingsAction = UIAlertAction(title: "前往设定", style: .default, handler: {
                                (action) -> Void in
                                let url = URL(string: UIApplication.openSettingsURLString)
                                if let url = url, UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in })
                                }
                            })
                            mAlert.addAction(action)
                            mAlert.addAction(settingsAction)
                            self.window?.rootViewController?.present(mAlert, animated: true, completion: nil)
                        }
                    })
                }
            default: break
            }
        }
        return true
    }
}

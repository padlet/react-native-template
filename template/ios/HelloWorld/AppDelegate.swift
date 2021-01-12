//
//  AppDelegate.swift
//  HelloWorld
//

import Foundation

import UIKit
#if FB_SONARKIT_ENABLED
import FlipperKit
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if FB_SONARKIT_ENABLED
        initializeFlipper()
        #endif
        
        guard let bridge = RCTBridge(delegate: self, launchOptions: nil) else { fatalError() }
        let rootView = RCTRootView(bridge: bridge, moduleName: "HelloWorld", initialProperties: nil)
        rootView.backgroundColor = .white
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let rootViewController = UIViewController()
        rootViewController.view = rootView
        window.rootViewController = rootViewController
        
        window.makeKeyAndVisible()
        return true
    }
}

#if FB_SONARKIT_ENABLED
// MARK: - Flipper
extension AppDelegate {
    private func initializeFlipper() {
        guard let client = FlipperClient.shared() else { assertionFailure(); return }
        client.add(FlipperKitLayoutPlugin(rootNode: self, with: SKDescriptorMapper(defaults: ())))
        client.add(FKUserDefaultsPlugin(suiteName: nil))
        client.add(FlipperKitReactPlugin())
        client.add(FlipperKitNetworkPlugin(networkAdapter: SKIOSNetworkAdapter()))
        client.start()
    }
}
#endif

extension AppDelegate: RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge) -> URL? {
        #if DEBUG
        return RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
        #else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
}

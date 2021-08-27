//
//  AppDelegate.swift
//  AlterSolutionsChallengeApp
//
//  Created by Marcos Lacerda on 27/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private lazy var appCoordinator: Coordinator? = makeAppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupApplication()
        return true
    }

}

// MARK: - Helpers

private extension AppDelegate {
    
    var rootController: UINavigationController {
        // swiftlint:disable force_cast
        return window!.rootViewController as! UINavigationController
    }
    
    func setupApplication() {
        UIView.setAnimationsEnabled(!isRunningUITests)

        if isRunningUnitTests && !isRunningUITests {
            window = UIWindow()
            window?.rootViewController = UIViewController()
            window?.makeKeyAndVisible()
        } else {
            // Start App Coordinator
            appCoordinator?.start()
        }
    }
    
    private func makeAppCoordinator() -> Coordinator? {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window)
        
        self.window = window
        
        return appCoordinator
    }

}

private extension AppDelegate {
    
    var isRunningUnitTests: Bool {
        // this means that we are running unit tests
        return ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
    }
    
    var isRunningUITests: Bool {
        var isRunningUITestsEnvironmentVariableValue = false
        
        // this is injected on the scheme arguments
        if let isRunningUITests = ProcessInfo.processInfo.environment["IS_RUNNING_UI_TESTS"] {
            isRunningUITestsEnvironmentVariableValue = isRunningUITests == "YES"
        }
        
        return ProcessInfo.processInfo.arguments.contains("UITestMode") || isRunningUITestsEnvironmentVariableValue
    }
    
}

//
//	Copyright © 2018 Makoto Yamanaka. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CrashlyticsDelegate {
	
	//────────────────────
	// MARK: ■ UIApplicationDelegate
	//────────────────────
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		// Crashlytics設定
		Crashlytics.sharedInstance().delegate = self
		
		// Firebase導入
		FirebaseApp.configure()
		
		return true
	}
	
	//────────────────────
	// MARK: ■ CrashlyticsDelegate
	//────────────────────
	
	func crashlyticsDidDetectReport(forLastExecution report: CLSReport, completionHandler: @escaping (Bool) -> Void) {
		print("•\(type(of: self)).\(#function) ·report=\(report.logString)")
		
		let value = UUID().uuidString
		report.setObjectValue(value, forKey: "last_breakpoint")
		
		DispatchQueue.main.async{
			UIAlertController.alert(
				title: "\(type(of: self)).\(#function)",
				message: "\(report.logString)",
				button: "OK")
				.startModal()
		}
		
		completionHandler(true)
	}
	
	func crashlyticsCanUseBackgroundSessions(_ crashlytics: Crashlytics) -> Bool {
		print("•\(type(of: self)).\(#function) ·crashlytics=\(crashlytics)")
		return true
	}
}

// MARK: -

extension CLSReport {
	var logString: String {
		return """
		\(self)
		•identifier=\(identifier)
		•customKeys=\(customKeys)
		•bundleVersion=\(bundleVersion)
		•bundleShortVersionString=\(bundleShortVersionString)
		•dateCreated=\(dateCreated)
		•osVersion=\(osVersion)
		•osBuildVersion=\(osBuildVersion)
		•isCrash=\(isCrash)
		•userIdentifier=\(userIdentifier.wrappedDescription)
		•userName=\(userName.wrappedDescription)
		•userEmail=\(userEmail.wrappedDescription)
		"""
	}
}

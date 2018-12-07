//
//	Copyright © 2018 Makoto Yamanaka. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		// Use Firebase library to configure APIs
		FirebaseApp.configure()
		
		return true
	}
}

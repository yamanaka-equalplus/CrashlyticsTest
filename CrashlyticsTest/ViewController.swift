//
//	Copyright © 2018 Makoto Yamanaka. All rights reserved.
//
import UIKit
import Crashlytics

class ViewController: UIViewController {
	
	//────────────────────
	// MARK: ■ Actions
	//────────────────────
	
	@IBAction func crashlyticsCrash() {
		Crashlytics.sharedInstance().crash()
	}
	
	@IBAction func crashlyticsThrowException() {
		Crashlytics.sharedInstance().throwException()
	}
	
	//────────────────────
	// MARK: ■ UIViewController override
	//────────────────────
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
}

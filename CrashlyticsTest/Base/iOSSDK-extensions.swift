//
//	Copyright © 2018 Makoto Yamanaka. All rights reserved.
//
import UIKit

//────────────────────
// MARK: - 
//────────────────────
extension Optional {
	/// 内容のdescription。もしくは"nil"。
	var wrappedDescription: String {
		guard let wrapped = self else{ return "nil" }
		return "\(wrapped)"
	}
}
//────────────────────
// MARK: - 
//────────────────────
extension UIAlertController {
	/// デフォルト引数追加版。
	convenience init(title: String? = nil, message: String? = nil, style: Style = .alert) {
		self.init(title: title, message: message, preferredStyle: style)
	}
	/// Action1つadd済みのStyle.alertを作成。
	class func alert(
		title: String? = nil, message: String? = nil,
		button: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> Self {
		let me = self.init(title: title, message: message, preferredStyle: .alert)
		me.addAction(title: button, style: style, handler: handler)
		return me
	}
	/// UIAlertAction.init()を引数に展開した版。
	@discardableResult
	func addAction(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction {
		let action = UIAlertAction(title: title, style: style, handler: handler)
		addAction(action)
		return action
	}
}
//────────────────────
// MARK: - 
//────────────────────
extension UIViewController {
	/// `rootViewController`から適切なViewControllerを探して`present()`。
	func startModal(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
		// dispatch asyncするのは、直前に別のVCのpresent()を呼んでいると、
		// Warning: Attempt to present 〜 while a presentation is in progress!
		// で失敗するのを回避するため。
		DispatchQueue.main.async{ //[weak self]しない。他で保持していないとnilになってしまうため。
			guard let root = UIApplication.shared.delegate?.window??.rootViewController else{ return }
			// presentedViewControllerをたどる。
			// isBeingDismissedをチェックするのは、直前に別のVCのdismiss()を呼んでいると、
			// Warning: Attempt to present 〜 on 〜 whose view is not in the window hierarchy!
			// で失敗するのを回避するため。
			var parent = root
			while let next = parent.presentedViewController, !next.isBeingDismissed {
				parent = next
			}
			//print("•\(type(of: self)).\(#function) ·parent=\(parent) ·BP=\(parent.isBeingPresented) ·BD=\(parent.isBeingDismissed)")
			parent.present(self, animated: animated, completion: completion)
		}
	}
	/// `presentedViewController`があればそれを`dismiss()`してから自身を`dismiss()`する。
	/// ※`dismiss()`は`presentedViewController`があると`presentedViewController`しか閉じない。
	func endModal(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
		if let _ = presentedViewController {
			// presented.dismiss()でなく、dismiss()とやると、presentedのpresentedがあっても一緒に閉じてくれる。
			dismiss(animated: animated) { [weak self] in
				self?.dismiss(animated: animated, completion: completion)
			}
		}else{
			dismiss(animated: animated, completion: completion)
		}
	}
}

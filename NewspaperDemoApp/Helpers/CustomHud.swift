//
//  CustomHud.swift
//  NewspaperDemoApp
//
//  Created by Hassan Raza on 31/03/2023.
//

import UIKit

class CustomHud: NSObject {
    
    static let sharedInstance = CustomHud()

    let indicator: UIActivityIndicatorView? = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    let screen = UIScreen.main.bounds

    var appDelegate: SceneDelegate {
        guard let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as? SceneDelegate else {
                fatalError("sceneDelegate is not UIApplication.shared.delegate")
        }
        return sceneDelegate
    }
    
    var rootController:UIViewController? {
        guard let viewController = appDelegate.window?.rootViewController else {
            fatalError("There is no root controller")
        }
        return viewController
    }
    
    func show() {
        indicator?.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator?.frame.origin.x = (screen.width/2 - 20)
        indicator?.frame.origin.y = (screen.height/2 - 20)
        rootController?.view.addSubview(indicator!)
        indicator?.startAnimating()
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.indicator?.stopAnimating()
            self.indicator?.removeFromSuperview()
        }
    }
}

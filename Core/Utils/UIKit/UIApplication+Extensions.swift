//
//  UIApplication.swift
//  Utils
//
//  Created by 송서영 on 2023/08/06.
//

import Foundation
import UIKit

extension UIApplication {
    public var topViewController: UIViewController? {
        guard let window = UIApplication.shared.keyWindow,
              let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController
    }
}

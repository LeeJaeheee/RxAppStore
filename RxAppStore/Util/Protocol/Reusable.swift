//
//  Reusable.swift
//  RxAppStore
//
//  Created by 이재희 on 4/7/24.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension UIView: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

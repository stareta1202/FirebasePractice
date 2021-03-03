//
//  UIView+ext.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/03.
//

import UIKit

extension UIView {
    @discardableResult
    func add<T: UIView>(_ subview: T, then closure: ((T) -> Void)? = nil) -> T {
        addSubview(subview)
        closure?(subview)
        return subview
    }
    
    @discardableResult
    func adds<T: UIView>(_ subviews: [T], then closure: (([T]) -> Void)? = nil) -> [T] {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
        return subviews
    }
}

extension UIView {
    static func custumButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        return button
        
    }
}

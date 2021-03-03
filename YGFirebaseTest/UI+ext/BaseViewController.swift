//
//  BaseViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/03.
//

import UIKit

class BaseViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        modalPresentationStyle = .fullScreen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.add(activityIndicator){
            $0.hidesWhenStopped = true
            $0.isHidden = true
            $0.center.x = super.view.center.x
            $0.center.y = super.view.center.y
        }
    }

}

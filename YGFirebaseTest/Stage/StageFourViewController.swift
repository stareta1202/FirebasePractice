//
//  StageFourViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/04.
//

import UIKit
import SnapKit
import Firebase

class StageFourViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var ref: DatabaseReference!
    

//    let timeJson:
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()
        
        view.add(button) {
            $0.setTitle("action", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
            $0.addTarget(self, action: #selector(self.action), for: .touchUpInside)
        }
        view.add(textField) {
            $0.placeholder = "값 입력하세요"
            $0.keyboardType = .default
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(112)
            }

        }
        view.add(printButton) {
            $0.setTitle("print", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(212)
            }
            $0.addTarget(self, action: #selector(self.printValue), for: .touchUpInside)
        }
    }
    
    // 버튼 눌렀을 때
    @objc func action() {
        // 파이어베이스에서 시간 분 -> 초에 해당하는 값 받아오기
//        ref.child("stage4/json").runTransactionBlock { (currentData: MutableData) -> TransactionResult in
//            if var post = currentData.value as [String : [String : AnyObject]] {
//
//            }
//        }
    }
    //
    @objc func updateVaule() {

    }
    @objc func printValue() {
        ref.child("stage4").runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
            var stars: Dictionary<String, Bool>
            stars = post["stars"] as? [String : Bool] ?? [:]
            var starCount = post["starCount"] as? Int ?? 0
            if let _ = stars[uid] {
              // Unstar the post and remove self from stars
              starCount -= 1
              stars.removeValue(forKey: uid)
            } else {
              // Star the post and add self to stars
              starCount += 1
              stars[uid] = true
            }
            post["starCount"] = starCount as AnyObject?
            post["stars"] = stars as AnyObject?

            // Set value and report transaction success
            currentData.value = post

            return TransactionResult.success(withValue: currentData)
          }
          return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
          if let error = error {
            print(error.localizedDescription)
          }
        }
    }
    

}


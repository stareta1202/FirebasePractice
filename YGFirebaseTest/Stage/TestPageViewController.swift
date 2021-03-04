//
//  TestPageViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/04.
//

import UIKit
import SnapKit
import Firebase

class TestPageViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var otherButton = UIButton.custumButton()
    var textField = UITextField()
    var otherTextField = UITextField()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ref = Database.database().reference()
        ref.child("stage3/setmessage")
        
        view.add(button) {
            $0.setTitle("updateChildValues", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            }
            $0.addTarget(self, action: #selector(self.action), for: .touchUpInside)
        }
        view.add(textField) {
            $0.placeholder = "키값 입력하세요"
            $0.keyboardType = .default
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(112)
            }

        }
        view.add(otherTextField) {
            $0.placeholder = "밸류 값 입력하세요"
            $0.keyboardType = .default
            $0.autocapitalizationType = .none
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(182)
            }

        }
        view.add(printButton) {
            $0.setTitle("트랜젝션 테스트", for: .normal)
            $0.backgroundColor = .black
            $0.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(270)
            }
            $0.addTarget(self, action: #selector(self.printValue), for: .touchUpInside)
        }
    }
    @objc func action() {
        var userID = "ssss"
        var username = "yongjun"
        var title = " hh"
        var body = 1234
        guard let key = ref.child("newchild").childByAutoId().key else { return }
        let post = ["uid": userID,
                    "author": username,
                    "title": title,
                    "body": body] as [String : Any]
        let childUpdates = ["/TestPage/\(key)": post]
        ref.updateChildValues(childUpdates)

        
    }
    @objc func printValue() {
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

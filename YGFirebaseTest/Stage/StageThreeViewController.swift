//
//  StageThreeViewController.swift
//  YGFirebaseTest
//
//  Created by Yongjun Lee on 2021/03/03.
//
//

import UIKit
import SnapKit
import Firebase

class StageThreeViewController: UIViewController {
    var button = UIButton.custumButton()
    var printButton = UIButton.custumButton()
    var textField = UITextField()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
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
    @objc func action() {
//        print("button pressed")
        self.ref = Database.database().reference()
//        let itemRef = self.ref.child("stage3/pushmessage")
//        itemRef.setValue("hello")
        
        self.ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
          if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
            var stage3: Dictionary<String, String>
            stage3 = post["stage3"] as? [String: String] ?? [:]
            var userCount = post["userCount"] as? Int ?? 0
            if let _ = stage3[uid] {
                userCount -= 1
            } else {
                userCount += 1
                stage3[uid] = "\(userCount)"
            }
            post["userCount"] = userCount as AnyObject?
            post["stage3"] = stage3 as AnyObject?
            
            //set value and report transaction success
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
    @objc func printValue() {
        print("hi")
        self.ref = Database.database().reference()
        self.ref.child("stage1").child("new").setValue("i changed it from stage3")
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

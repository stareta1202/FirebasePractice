# FirebasePractice
This repo is for praticing firebase(database, auth) and login page 
[Firebase Tutorial/Explanation from Google](https://firebase.google.com/docs/database/ios/read-and-write)
## stage1 
> access value and create value
> used ```.setValue```

## stage2
> Get ```value``` from Client(user, UI), write on Database Realtime

## stage3 
> Get ``` values ``` from many of users and write with AutoCreatedUID or from textField to prevent from overlapping
``` Swift
  ref.child("stage3/setmessage/\(textField.text!)").setValue(otherTextField.text)
  ref.child("stage3/setmessage").childByAutoId().setValue(otherTextField.text)
``` 
## stage4
> save data as transactions When working with data that could be corrupted by concurrent modifications, such as incremental counters, you can use a transaction operation. You give this operation two arguments: an update function and an optional completion callback. The update function takes the current state of the data as an argument and returns the new desired state you would like to write.

``` Swift
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
}
```

## stage5
> observe( listener) : While listening for child events is the recommended way to read lists of data, there are situations listening for value events on a list reference is useful.
``` Swift
        self.stage5Ref.child("target").observe(.childChanged) { (snapshot) in
            let changedName = snapshot.value as! String
            print(snapshot.value)
            self.stage5Ref.child("user").observeSingleEvent(of: .value) { (dataSnapshot) in
                let dic = dataSnapshot.value as! [String: Any]
                for index in dic {
                    if index.key == changedName {
                        self.targetLabel.text = index.value as! String
                    }
                }
            }
```

## stage6
> Recursion

## stage7
> Attach  ``` Listner ``` at end node
``` Swift
    override func viewWillDisappear(_ animated: Bool) {
        self.stage7Ref.removeAllObservers()
    }
    
    private func observing() { // use it at viewDidLoad
        self.stage7Ref.child("message").observe(.value) { (snapshot) in

            for index in snapshot.children {
                let snap = index as! DataSnapshot
                var tempStr = snap.value as! String
                var lowedStr = tempStr.lowercased()
                self.stage7Ref.child("message/\(snap.key)").setValue(lowedStr)
            }
        }
    }
```

## stage8 
> use Transaction which "Using a transaction prevents star counts from being incorrect if multiple users star the same post at the same time or the client had stale data. The value contained in the FIRMutableData class is initially the client's last known value for the path, or nil if there is none. The server compares the initial value against it's current value and accepts the transaction if the values match, or rejects it. If the transaction is rejected, the server returns the current value to the client, which runs the transaction again with the updated value. This repeats until the transaction is accepted or too many attempts have been made.

``` Swift
    func tempFunc() {
        
        if mTimer.isValid {
            mTimer.invalidate()
        }
        
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(obcTempFunc), userInfo: nil, repeats: true)
    }
    
    @objc func obcTempFunc() {
        var date = Date()
        self.stage8Ref.child("json/\(Calendar.current.component(.hour, from: Date()))/\(Calendar.current.component(.minute, from: Date()))").runTransactionBlock { (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String: AnyObject]{
                print(post)
                self.number = post["number"] as! Int ?? 0
                self.flag = post["flag"] as! Bool
                if self.flag {
                    self.number += 1
                }
                print("number is?", self.number)
                
//                post["number"] = self.number as AnyObject?
                post["number"] = self.number as AnyObject?
                currentData.value = post
                
            }
            return TransactionResult.success(withValue: currentData)
        } andCompletionBlock: { (error, commit, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
        
```

## stage9 
> Type casting


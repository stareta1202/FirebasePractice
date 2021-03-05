# FirebasePractice
This repo is for praticing firebase(database, auth) and login page 

## stage1 
> access value and create value
> used ```.setValue```

## stage2
> Get ```value``` from Client(user, UI), write on Database Realtime

## stage3 
> Get ``` values ``` from many of users and write with AutoCreatedUID or from textField
``` Swift
  ref.child("stage3/setmessage/\(textField.text!)").setValue(otherTextField.text)
  ref.child("stage3/setmessage").childByAutoId().setValue(otherTextField.text)
``` 



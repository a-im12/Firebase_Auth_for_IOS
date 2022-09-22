//
//  UserAuth.swift
//  20220919Authtest
//
//  Created by いーま on 2022/09/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserAuth{
    
    var uid:String = ""
    var email:String = ""

    let db = Firestore.firestore()
    let userInfo = UserInfo()
    
    // ユーザの新規作成
    func createUser(email: String, pass: String){
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            guard authResult?.user != nil else{
                print("登録できません")
                return
            }
        }
    }
    // Firestoreへのアクセス
    func accessUserDB(uid:String, email:String){
        self.db.collection("users").document(uid).getDocument(){(document, error) in
            if let document = document {
                if document.exists{
                    print("already done")
                }else{
                    // 新規ユーザの場合はドキュメントの作成
                    self.userInfo.createNewUserDocument(uid: uid, email:email)
                }
            }
        }
    }
    
    // ログアウト処理
    func logOut() -> Bool{
        let firebaseAuth = Auth.auth()
        var isSuccess = false
        do {
            try firebaseAuth.signOut()
            defer{
                isSuccess = true
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        return isSuccess
    }
    
    // userIdの取得
    func getUserId() -> String{
        return self.uid
    }
    
    // emailの取得
    func getUserEmail() -> String{
        return self.email
    }
}

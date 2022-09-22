//
//  SignUpView.swift
//  20220919Authtest
//
//  Created by いーま on 2022/09/19.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    
    let userAuth:UserAuth = UserAuth()
    let userInfo:UserInfo = UserInfo()
    
    @State var mail:String = ""
    @State var pass:String = ""
    @State var errorMessage = ""
    var body: some View {
        VStack{
            TextField("mailaddress", text: $mail)
            TextField("password", text: $pass)
            Button(action:{
                
                print("登録ボタン押下")
                // 入力欄のチェック 入力不備あり: エラーメッセージ, 不備なし: ""
                errorMessage = userInfo.checkEntry(email: mail, pass: pass)
                
                if errorMessage == ""{
                    // 新規ユーザの作成
                    userAuth.createUser(email: mail, pass: pass)
                }else{
                    print(errorMessage)
                }
            }){
                Text("Sign Up")
            }.padding()
        }
    }
}


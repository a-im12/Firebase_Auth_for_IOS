//
//  ContentView.swift
//  20220919Authtest
//
//  Created by いーま on 2022/09/19.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    
    let db = Firestore.firestore()
    var userInfo:UserInfo = UserInfo()
    var userAuth:UserAuth = UserAuth()
    
    @State var mail:String = ""
    @State var pass:String = ""
    @State var errorMessage:String = ""
    @State var isLogin:Bool = false
    @State var uid:String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("mailaddress", text: $mail)
                TextField("password", text: $pass)
                Button(action:{
                    // 入力欄のチェック 正しい入力: "", 入力エラー: エラーメッセージ
                    errorMessage = userInfo.checkEntry(email: mail, pass: pass)
                    
                    if errorMessage == ""{
                        // ユーザ認証
                        Auth.auth().signIn(withEmail: mail, password: pass) {(authResult, error) in
                            guard authResult?.user != nil else{
                                print("認証失敗")
                                return
                            }
                            if let user = authResult?.user{
                                uid = user.uid
                                mail = user.email ?? ""
                                
                                // 新規ユーザのドキュメントの作成。　既存ユーザの場合は作成されない。
                                userAuth.accessUserDB(uid: uid, email: mail)
                                // 画面遷移するために変換
                                isLogin = true
                            }
                        }
                    }else{
                        print(errorMessage)
                    }
                }){
                    Text("ログイン")
                }.padding()
                
                // sign in画面への遷移
                NavigationLink(destination: SignUpView()){
                    Text("登録されていない方はこちら")
                }
                
                NavigationLink(destination: UserView(uid: uid), isActive: $isLogin){
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

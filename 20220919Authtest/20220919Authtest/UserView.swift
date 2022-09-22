//
//  UserView.swift
//  20220919Authtest
//
//  Created by いーま on 2022/09/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct UserView: View {
     
    var uid:String
    var db = Firestore.firestore()
    var userInfo:UserInfo = UserInfo()
    let userAuth:UserAuth = UserAuth()
    @State var isLogout = false     // ログイン画面へ戻るための変数
    
    init(uid: String) {
        self.uid = uid
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello")
                Button(action:{
                    // 登録されているユーザの情報を取得して表示
                    userInfo.getUserInfo(uid: uid)
                }){
                    Text("ユーザ情報の表示")
                }.padding()
                
                Button(action:{
                    // ログアウト処理
                    isLogout = userAuth.logOut()
                }){
                    Text("ログアウト")
                }
                
            }.navigationTitle("マイページ")
        }
        
        NavigationLink(destination: ContentView(), isActive: $isLogout){
            EmptyView()
        }
        
    }
}


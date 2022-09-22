//
//  RootView.swift
//  20220919Authtest
//
//  Created by いーま on 2022/09/20.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        if appState.isLogin{
            ContentView()
        }else{
            UserView()
        }
    }
}
 
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

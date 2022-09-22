//
//  AppState.swift
//  20220919Authtest
//
//  Created by いーま on 2022/09/20.
//

import Foundation

import Foundation

class AppState: ObservableObject {
   @Published var isNavigateToLoginView = false
   @Published var isNavigateToPasswordResetView = false
   @Published var isLogin = false
}

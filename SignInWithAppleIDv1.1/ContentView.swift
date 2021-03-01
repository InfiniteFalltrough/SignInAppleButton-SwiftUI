//
//  ContentView.swift
//  SignInWithAppleIDv1.1
//
//  Created by Viktor Golubenkov on 28.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var signInWithAppleManager: SignInManager
    
    var body: some View {
        ZStack {
            if signInWithAppleManager.isUserAuthenticated == .undefined {
                InitialView()
            } else if signInWithAppleManager.isUserAuthenticated == .signedOut {
                LoginView()
            } else if signInWithAppleManager.isUserAuthenticated == .signedIn {
                MainTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

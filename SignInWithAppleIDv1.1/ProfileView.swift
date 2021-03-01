//
//  ProfileView.swift
//  SignInWithAppleIDv1.1
//
//  Created by Viktor Golubenkov on 28.02.2021.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var signInWithAppleManager: SignInManager
    
    var body: some View {
        NavigationView {
            VStack() {
                Text("User identifier: \(UserDefaults.standard.string(forKey: signInWithAppleManager.userIdentifierKey)!)")
                Spacer()
            }.padding()
                .navigationBarTitle("Welcome")
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

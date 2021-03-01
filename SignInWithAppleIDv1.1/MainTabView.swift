//
//  MainTabView.swift
//  SignInWithAppleIDv1.1
//
//  Created by Viktor Golubenkov on 28.02.2021.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selected = 1
    
    var body: some View {
        TabView(selection: $selected) {
            NewsView().tabItem {
                Image(systemName: "rectangle.stack")
                }.tag(0)
            
            ProfileView().tabItem {
                Image(systemName: "person.circle.fill")
            }.tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

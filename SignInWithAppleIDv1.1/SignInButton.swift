//
//  SignInButton.swift
//  SignInWithAppleIDv1.1
//
//  Created by Viktor Golubenkov on 28.02.2021.
//

import SwiftUI
import AuthenticationServices

final class SignInButton: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<SignInButton>) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: SignInButton.UIViewType, context: UIViewRepresentableContext<SignInButton>) {
    }
}

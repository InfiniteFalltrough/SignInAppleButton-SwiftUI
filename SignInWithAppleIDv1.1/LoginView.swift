//
//  LoginView.swift
//  SignInWithAppleIDv1.1
//
//  Created by Viktor Golubenkov on 28.02.2021.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @EnvironmentObject var signInWithAppleManager: SignInManager
    
    @Environment(\.window) var window: UIWindow?
    
    @State private var signInWithAppleDelegates: SignInDelegates! = nil
    
    @State private var isAlertPresented = false
    @State private var errorDescription = ""
    
    var body: some View {
        SignInButton()
            .frame(width: 200, height: 40, alignment: .center)
            .onTapGesture {
                self.showAppleLogin()
            }.alert(isPresented: $isAlertPresented) {
                Alert(title: Text("Error"), message: Text(errorDescription), dismissButton: .default(Text("Ok"), action: {
                    // set isUserAuthenticated to signed out
                    self.signInWithAppleManager.isUserAuthenticated = .signedOut
                }))
            }
    }
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [
            .fullName,
            .email
        ]
        
        performSignIn(using: [request])
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        
        signInWithAppleDelegates = SignInDelegates(window: window, onSignedIn: { (result) in
            switch result {
            
            case .success(let userId):
                self.signInWithAppleManager.isUserAuthenticated = .signedIn
                UserDefaults.standard.set(userId, forKey: signInWithAppleManager.userIdentifierKey)
            case .failure(let error):
                self.errorDescription = error.localizedDescription
                self.isAlertPresented = true
            }
        })
        
        let controller = ASAuthorizationController(authorizationRequests: requests)
        
        controller.delegate = signInWithAppleDelegates
        
        controller.presentationContextProvider = signInWithAppleDelegates
        
        controller.performRequests()
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

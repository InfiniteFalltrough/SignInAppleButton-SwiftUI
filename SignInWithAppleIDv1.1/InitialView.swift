//
//  InitialView.swift
//  SignInWithAppleIDv1.1
//
//  Created by Viktor Golubenkov on 28.02.2021.
//

import SwiftUI
import AuthenticationServices

struct InitialView: View {
    
    @EnvironmentObject var signInWithAppleManager: SignInManager
    
    @Environment(\.window) var window: UIWindow?
    
    @State private var signInWithAppleDelegates: SignInDelegates! = nil
    
    @State private var isAlertPresented = false
    @State private var errorDescription = ""
    
    var body: some View {
        VStack {
            Text("Loading...")
        }.onAppear {
            // check user auth
            self.signInWithAppleManager.checkUserAuth { (authState) in
                switch authState {
                
                case .undefined:
                    print("undefined")
                    self.performExistingAccountSetupFlows()
                case .signedOut:
                    print("signedOut")
                case .signedIn:
                    print("signedIn")
                }
            }
            
        }.alert(isPresented: $isAlertPresented) {
            Alert(title: Text("Error"), message: Text(errorDescription), dismissButton: .default(Text("Ok"), action: {
                // set isUserAuthenticated to signed out
                self.signInWithAppleManager.isUserAuthenticated = .signedOut
            }))
        }
    }
    
    private func performExistingAccountSetupFlows() {
//        #if !targetEnvironment(simulator)
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        performSignIn(using: requests)
//        #endif
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

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}

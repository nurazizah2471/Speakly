//
//  SignInButtonView.swift
//  Speakly
//
//  Created by Nur Azizah on 22/11/23.
//

import SwiftUI
import AuthenticationServices

struct SignInButtonView: View {
    @Environment(\.userViewModel) private var userViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            SignInWithAppleButton(.continue) { request in
                request.requestedScopes = [.email, .fullName]
                
            } onCompletion: { result in
                isLoading = true
                
                switch result {
                case .success(let auth):
                    switch auth.credential {
                    case let credential as ASAuthorizationAppleIDCredential:
                        
                        let userID = credential.user
                        let firstName = credential.fullName?.givenName
                        let lastName = credential.fullName?.familyName
                        let email = credential.email
                        
                       // userViewModel.deleteAllUser()
                        if userViewModel.findUser(userID: userID)?.count == 0 {
                            userViewModel.addUser(userData: UserModel(userID: userID, firstName: firstName ?? "", lastName: lastName ?? "", email: email ?? ""))
                        }
                        userViewModel.setUserLogin(userID)
                    default:
                        break
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                sleep(1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isLoading = false
                }
            }
            .signInWithAppleButtonStyle(
                colorScheme == .dark ? .white : .black
            )
            .frame(height: 50.0)
            .padding()
            .cornerRadius(10.0)
        }
    }
}

#Preview {
    SignInButtonView(isLoading: .constant(false))
}

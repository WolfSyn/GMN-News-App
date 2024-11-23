//
//  LoginView.swift
//  xcode Tutorial Demo
//
//  Created by Carlos Daniel Garcia on 8/21/24.
//

import SwiftUI

enum FocusedField {
    case email
    case password
}

struct LoginView: View {
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) &&
            Validator.validatePassword(passwordText)
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login Here")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(.bottom)
                Text("Welcome Back see what you have missed!")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                TextField("Email", text: $emailText)
                    .focused($focusedField, equals: .email)
                    .padding()
                    .background(Color("secondaryBlue"))
                    .cornerRadius(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(!isValidEmail ? .red :focusedField == .email ? Color("PrimaryBlue"): .white,
                                    lineWidth: 3)
                    )
                    .padding(.horizontal)
                    .onChange(of: emailText) { newValue in
                        isValidEmail = Validator.validateEmail(newValue)
                    }
                if !isValidEmail {
                    HStack {
                        Text("Your Email is not valid")
                            .foregroundColor(.red)
                            .padding(.leading)
                        Spacer()
                    }
                }
                SecureField("Password", text: $passwordText)
                    .focused($focusedField, equals: .password)
                    .padding()
                    .background(Color("secondaryBlue"))
                    .cornerRadius(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(!isValidPassword ? .red : focusedField == .password ? Color("PrimaryBlue"): .white, lineWidth: 5)
                    )
                    .padding(.horizontal)
                    .onChange(of: passwordText) { newValue in
                        isValidPassword = Validator.validatePassword(newValue)
                    }
                if !isValidPassword {
                    HStack {
                        Text("Your password is not valid")
                            .foregroundColor(.red)
                            .padding(.leading)
                        Spacer()
                    }
                }
                
                HStack {
                    Spacer()
                    Button {
                        //action
                    } label: {
                        Text("Forgot Your Password?")
                            .foregroundColor(Color("PrimaryBlue"))
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.trailing)
                }
                
                Button {
                    //action
                } label:{
                    Text("Sign In")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color("PrimaryBlue"))
                .cornerRadius(12)
                .padding(.horizontal)
                .opacity(canProceed ? 1.0 : 0.5)
                .disabled(!canProceed)
                
                Button {
                    //action
                } label:{
                    Text("Create New Account")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("Gray"))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .padding(.horizontal)
                
                BottonView()
            }
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct BottonView: View {
    var body: some View {
        VStack {
            Text("Or Continue With")
                .font(.system(size: 14))
                .foregroundColor(Color("PrimaryBlue"))
                .padding(.bottom)
            
            HStack {
                Button {
                    //Action
                } label: {
                    Image("google-logo")
                }
                .iconButtonStyle
                
                Button {
                    //Action
                } label: {
                    Image("facebook-logo")
                }
                .iconButtonStyle
                
                Button {
                    //Action
                } label: {
                    Image("apple-logo")
                }
                .iconButtonStyle
            }
        }
    }
}
extension View {
    var iconButtonStyle: some View {
        self
            .padding()
            .background(Color("lightGray"))
            .cornerRadius(8)
    }
}

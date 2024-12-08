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
    @EnvironmentObject var viewModel: ViewModel
    
    
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var isValidEmail = true
    @State private var isValidPassword = true
    
    @State private var showSheet = false
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) &&
            Validator.validatePassword(passwordText)
    }
    
    @FocusState private var focusedField: FocusedField?
    // Start of the Login
    var body: some View {
        NavigationStack {
            ZStack{
                if viewModel.isLoading {
                    ProgressView()
                }
                VStack {
                    Text("Login Here")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("PrimaryBlue"))
                        .padding(.bottom)
                    Text("Welcome Back see what you have missed!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                    
                    EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                    
                    
                    PasswordTextField(passwordText: $passwordText, isValidPassword: $isValidPassword, validatePassword: Validator.validatePassword, errorText: "Your password is not valid", placeholder: "Password")
                    
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
                        .padding(.vertical)
                    }

                    
                    // the start of the Sign in button
                    Button {
                        Task {
                            try? await viewModel.login(email: emailText, password: passwordText)
                        }
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
                    
                    // the start of the create new account button
                    Button {
                        showSheet.toggle()
                    } label:{
                        Text("Create New Account")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color("Gray"))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding([.horizontal, .vertical])
                    
                    BottonView(googleAction: {}, facebookAction: {}, appleAction: {})
                }
                .opacity(viewModel.isLoading ? 0.1 : 1)
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                Text("Logged In!")
            }
        }
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("Ok") {
                isValidEmail = false
                isValidPassword = false
                emailText = ""
                passwordText = ""
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .sheet(isPresented: $showSheet) {
            RegistrationView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct BottonView: View {
    var googleAction: () -> Void
    var facebookAction: () -> Void
    var appleAction: () -> Void

    var body: some View {
        VStack {
            Text("Or Continue With")
                .font(.system(size: 14))
                .foregroundColor(Color("PrimaryBlue"))
                .padding(.bottom)
            
            HStack {
                Button {
                    googleAction()
                } label: {
                    Image("google-logo")
                }
                .iconButtonStyle
                
                Button {
                    facebookAction()
                } label: {
                    Image("facebook-logo")
                }
                .iconButtonStyle
                
                Button {
                    appleAction()
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

struct EmailTextField: View {
    @Binding var emailText: String
    @Binding var isValidEmail: Bool
    
    @FocusState var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            TextField("Email", text: $emailText) // the start on inserting your email
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
                .padding(.bottom, isValidEmail ? 16 : 0)
            
            
            if !isValidEmail {
                HStack {
                    Text("Your Email is not valid")
                        .foregroundColor(.red)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
            }
        }
    }
}

struct PasswordTextField: View {
    @Binding var passwordText: String
    @Binding var isValidPassword: Bool
    let validatePassword: (String) -> Bool
    let errorText: String
    let placeholder: String
    
    @FocusState var focusField: FocusedField?
    
    // the start on inserting your password 
    var body: some View {
        VStack {
            SecureField(placeholder,  text: $passwordText)
                .focused($focusField, equals: .password)
                .padding()
                .background(Color("secondaryBlue"))
                .cornerRadius(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!isValidPassword ? .red : focusField == .password ? Color("PrimaryBlue"): .white, lineWidth: 5)
                )
                .padding(.horizontal)
                .onChange(of: passwordText) { newValue in
                    isValidPassword = validatePassword(newValue)
                }
            if !isValidPassword {
                HStack {
                    Text(errorText)
                        .foregroundColor(.red)
                        .padding(.leading)
                    Spacer()
                }
            }
        }
    }
}


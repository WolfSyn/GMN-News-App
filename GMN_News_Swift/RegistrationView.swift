//
//  RegistrationView.swift
//  xcode Tutorial Demo
//
//  Created by Carlos Daniel Garcia on 8/21/24.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: Viewmodel
    @Environment(\.dismiss) var dismiss
    @State private var emailText = "" //This cooralates with "EMAIL"
    @State private var passwordText = "" // This coorlates with "PASSWORD"
    @State private var confirmPasswordText = "" // This coorlates with "CONFIRMPASSWORD"

    @State private var isValidEmail = true // This validates the "EMAIL" (if it does not have the @ symbol then it won't work)
    @State private var isValidPassword = true // This validates the "PASSWORD"
    @State private var isConfirmPasswordValid = true // This validates the Confirmed Password again the 2nd time

    @State private var showSheet = false
    
    
    var canProceed: Bool {
        Validator.validateEmail(emailText) &&
            Validator.validatePassword(passwordText)
    }
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading{
                    ProgressView()
                }
                VStack { // The start of registration page 
                    Text("Create Account")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("PrimaryGray"))
                        .padding(.bottom)
                        .padding(.top, 48)
                    Text("Create an account so you can explore all on what's happening in the world of Gaming")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                    
                    EmailTextField(emailText: $emailText, isValidEmail: $isValidEmail)
                    
                    PasswordTextField(passwordText: $passwordText, isValidPassword: $isConfirmPasswordValid, validatePassword: Validator.validatePassword, errorText: "Your password is not valid", placeholder: "Password")
                    
                    PasswordTextField(passwordText: $confirmPasswordText, isValidPassword: $isValidPassword, validatePassword: validateConfirm, errorText: "Your password is not matching", placeholder: "Confirm Password")
                    
                        .padding(.top)
                    Spacer()
                    
                    
                    Button {
                        Task {
                            try? await viewModel.createUser(email: emailText, password: passwordText)
                        }
                    } label:{
                        Text("Sign Up")
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
                        showSheet.toggle()
                    } label:{
                        Text("Already have an account")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color("Gray"))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding([.horizontal, .vertical])
                    
                    BottonView(googleAction: {}, facebookAction: {}, appleAction: {})
                    Spacer()
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
            }
        }
        .alert(viewModel.hasError ? "Error" : "Success", isPresented: $viewModel.showAlert) {
            if viewModel.hasError {
                Button("Try Again") {}
            } else {
                Button("Ok") {
                    dismiss()
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .sheet(isPresented: $showSheet) {
            LoginView()
        }
    }
    
    func validateConfirm(_ password: String) -> Bool {
        passwordText == password
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

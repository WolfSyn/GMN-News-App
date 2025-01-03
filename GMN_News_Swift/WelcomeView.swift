//
//  ContentView.swift
//  xcode Tutorial Demo
//
//  Created by Carlos Daniel Garcia on 8/4/24.
//

import SwiftUI

enum ViewStack {
    case login
    case registration
}
// This will take you to the main page on what you want to get into either you register or login
struct WelcomeView: View {
    @State private var presentNextView = false
    @State private var nextView: ViewStack = .login
    var body: some View {
        NavigationStack {
            VStack {
                Image("work-from-home") // change to your dedicated background as in logo or other image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 370)
                    .padding(.top, 24)
                
                Spacer()
                
                Text("Welcome to GMN News")
                    .font(.system(size: 35, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(.bottom, 8)
                Text("Explore all the exisiting Deals & Gaming News Based on your Interests")
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.black))
                    .padding(.bottom, 8)
                
                Spacer()
                // The start of the login button
                HStack(spacing: 12) {
                    Button {
                        nextView = .login
                        presentNextView.toggle()
                    } label: {
                        Text("Login")
                            .font(.system(size: 20, weight:
                                    .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: 160, height: 60)
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(12)
                    // The start of the Register Button
                    Button {
                        nextView = .registration
                        presentNextView.toggle()
                    } label: {
                        Text("Register")
                            .font(.system(size: 20, weight:
                                    .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 160, height: 60)
                }
                
                Spacer()
            }// When clicking login or Resigter button it will take you to dedeicated location
            .padding()
            .navigationDestination(isPresented:
                $presentNextView) {
                switch nextView {
                case .login:
                    LoginView()
                case .registration:
                    RegistrationView()
                }
            }
        }
    }
}
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

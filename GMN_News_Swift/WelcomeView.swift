//
//  ContentView.swift
//  xcode Tutorial Demo
//
//  Created by Carlos Daniel Garcia on 8/4/24.
//

import SwiftUI

enum ViewStack { // Use this code to change next screen 
    case login // e.g. -> when click login it will take you to that page
    case registration // e.g. -> when click registration it will take you to that page
}
// This will take you to the main page on what you want to get into either you register or login
struct WelcomeView: View {
    @State private var presentNextView = false //This goes with the enum case, also the one under it. 
    @State private var nextView: ViewStack = .login
    var body: some View {
        NavigationStack {
            VStack {
                //start of the logo-
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
                        nextView = .login //present where it will navigate to its next page.
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
                        nextView = .registration // present where it will navigate towards
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
                $presentNextView) { // The start of switching screens
                switch nextView { // switch command will help nav to the next view when clicking that button on simulator
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

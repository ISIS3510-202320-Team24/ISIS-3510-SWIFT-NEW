//
//  ProfileView.swift
//  UniShop-iOS
//
//  Created by Alejandro Gonzalez on 2/10/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? "name"
    @State private var phoneNumber: String = UserDefaults.standard.string(forKey: "userPhone") ?? "phone"
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? "username"
    @State private var email: String = UserDefaults.standard.string(forKey: "userEmail") ?? "email"
    @State private var degree: String = UserDefaults.standard.string(forKey: "userDegree") ?? "degree"
    @State private var showAlert = false
    @StateObject private var profileController = ProfileViewController()
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)
        ]
        navBarAppearance.backgroundEffect = UIBlurEffect(style: .light)
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.23, green: 0.23, blue: 0.23))
                .frame(width: 75, alignment: .leading)
            
            Text(value)
                .font(.custom("Archivo-Regular", size: 17))
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .padding([.leading, .trailing], 15)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 20) {
                Image("img_maskgroup")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 91.45, height: 133.55)
                    .clipped()
                Text(name)
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            
            HStack {
                Text("Personal Information")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            
            infoRow(title: "Name:", value: name)
            infoRow(title: "User:", value: username)
            infoRow(title: "Email:", value: email)
            infoRow(title: "Phone:", value: phoneNumber)
            infoRow(title: "Degree:", value: degree)
            
            HStack {
                Text("In Trouble?")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15))
                
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            .padding(.top, 20)
            
            HStack {
                Text("Ask for help!")
                    .font(.system(size: 18, design: .default))
                    .foregroundColor(Color(red: 0.067, green: 0.075, blue: 0.082))
                
                Spacer()
            }
            .padding([.leading, .trailing], 15)
            
            Button(action: {
                profileController.sendAlertAPI()
            }) {
                Text("HELP!")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 1, green: 0.776, blue: 0))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $profileController.showingAlert) {
                SwiftUI.Alert(title: Text("Alert Sent"), message: Text(profileController.alertMessage), dismissButton: .default(Text("OK")))
            }
            .padding(.top, 10)
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 25)
        .navigationBarTitle(name, displayMode: .inline)
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(.yellow)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


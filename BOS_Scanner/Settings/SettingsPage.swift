//  SettingsPage.swift
//  BOS_Scanner
//
//  This file defines the SettingsPage, which provides navigation to various settings views
//  such as Privacy and (optionally) General settings. The page includes toggles for various
//  user preferences like Dark Mode, Tracking, and Local Storage in the GeneralSettingsView,
//  and it presents privacy-related information in the PrivacySettingsView.
//
//  Created by EC.

import SwiftUI
import SwiftData


struct GeneralSettingsView: View {
    @State private var toggle1 = false
    @State private var toggle2 = false
    @State private var toggle3 = false
    @State private var toggle4 = false
   
    
    var body: some View {
            ZStack {
               

                VStack(spacing: 15) {

                    Toggle("Dark Mode", isOn: $toggle1)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)

                    Toggle("Tracking", isOn: $toggle2)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)

                    Toggle("Local Storage", isOn: $toggle3)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)

                    Toggle("Share Data", isOn: $toggle4)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)

                    Spacer()
                }
                .padding()
            }
        }
    
}



struct PrivacySettingsView: View {
   
    var body: some View {
        ZStack {
         
            ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Disclaimer")
                                .font(.title2)
                                .padding(.top)

                            Text("""
                            This app is intended for informational and educational purposes only and is not a substitute for professional advice. Users should always seek the advice of qualified professionals regarding any specific concerns or issues they may have.

                            """)
                            .padding(.horizontal)
                            
                            
                            Text("Privacy Statement")
                                .font(.title2)
                                .padding(.top)

                            Text("""
                            Your privacy is important to us. This app does not collect or store any personal data without your explicit consent. Any information provided by the user is stored securely and is only used to enhance the app's functionality. We do not share your information with third parties.
                            """)
                            .padding(.horizontal)

                            Spacer()
                        }
                        .padding()
                    }
            .padding()
        }
    }
}


struct SettingsRowView: View {
    var settingName: String
    
    var body: some View {
        HStack {
            Text(settingName)
                .font(.title3)
        
        }
        .padding()
    }
}


struct SettingsPage: View {
    var body: some View {
        NavigationStack {
            ZStack {
                List {
//                    NavigationLink(destination: GeneralSettingsView()) {
//                        SettingsRowView(settingName: "General")
//                    }
//                    .listRowBackground(Color.clear)
//                    .background(Color.clear)
//                    
                    NavigationLink(destination: PrivacySettingsView()) {
                        SettingsRowView(settingName: "Privacy")
                    }
                    .listRowBackground(Color.clear)
                    .background(Color.clear)
                }
                .listStyle(PlainListStyle())
            }
            .background(Color(UIColor.systemBackground))
        }
        .foregroundColor(Color.primary)
        .background(Color(UIColor.systemBackground))
    }
}


#Preview {
    SettingsPage()
}

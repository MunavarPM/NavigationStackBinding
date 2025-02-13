//
//  OTPView.swift
//  NavigationByBinding
//
//  Created by Munavar PM on 13/01/25.
//

import SwiftUI

struct OTPView: View {
    @Binding var isDownRoot: Bool
    @Binding var toRoot: Bool
    @Binding var setRoot: Bool
    @State var isNavigateToHomeView = false
    @State var showLoggin = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            NavigationLink("", destination: HomeView(isDownRoot: self.$isDownRoot, isSetRoot: $setRoot).navigationBarBackButtonHidden(true), isActive: self.$showLoggin)
                .isDetailLink(false)
            Button(action: {
                dismiss()
            }, label: {
                HStack {
                    Image(systemName: "arrow.backward")
                    Text("Back")
                        .fontWeight(.bold)
                }
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
            })
            
            Spacer()
            
            Text("OTP View!")
                .padding(.vertical)
            
            NavigationLink(destination: HomeView(isDownRoot: self.$isDownRoot, isSetRoot: $setRoot)) {
                Text("Submit")
            }
            .isDetailLink(false)
            Spacer()
        }
    }
}

#Preview {
    OTPView(isDownRoot: .constant(false), toRoot: .constant(false), setRoot: .constant(false))
}

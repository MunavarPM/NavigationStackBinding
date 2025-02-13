//
//  ViewThree.swift
//  NavigationByBinding
//
//  Created by Munavar PM on 13/01/25.
//

import SwiftUI

struct ViewThree: View {
    @Binding var toRoot: Bool
    @Binding var setRoot: Bool
    @State var isDownRoot = false
    @Environment(\.dismiss) var dismiss
    @State var isNavigateToHomeView = false

    var body: some View {
        ZStack {
            VStack {
                NavigationLink("", destination: HomeView(isDownRoot: $isDownRoot, isSetRoot: $setRoot).navigationBarBackButtonHidden(true), isActive: $isNavigateToHomeView)

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
                Text("View Three!")

                ScrollView {
                    ForEach(1 ... 10, id: \.self) { index in
                        Text("Item Item Item Item Item Item Item Item Item \(index)")
                            .padding(.vertical, 5)
                    }
                }

                Button("Navigate to Root") {
                    self.toRoot = false
                    self.isDownRoot = false
                    self.isNavigateToHomeView = true
                }
            }
        }
        .onDisappear {
            self.isNavigateToHomeView = false
            print("isNavigateToHomeView Condition in ViewThree :- \(isNavigateToHomeView)")
            print("toRoot Condition in ViewThree :- \(toRoot)")
        }
    }
}

//#Preview {
//    ViewThree(toRoot: .constant(false))
//}

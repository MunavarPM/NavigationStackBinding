//
//  ViewOne.swift
//  NavigationByBinding
//
//  Created by Munavar PM on 13/01/25.
//

import SwiftUI

struct ViewOne: View {
    @State private var isNavigateViewTwo = false
    @Binding var toRoot: Bool
    @Binding var setRoot: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack {
                NavigationLink("", destination: ViewTwo(toRoot: $toRoot, setRoot: $setRoot).navigationBarBackButtonHidden(true), isActive: $isNavigateViewTwo)

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
                Text("View One")

                ScrollView {
                    ForEach(1 ... 10, id: \.self) { index in
                        Text("Item Item Item Item Item Item Item Item Item \(index)")
                            .padding(.vertical, 5)
                    }
                }

                Button("Navigate to View Two") {
                    isNavigateViewTwo = true
                }
            }
        }
    }
}

//#Preview {
//    ViewOne(toRoot: .constant(false))
//}

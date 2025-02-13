//
//  ContentView.swift
//  NavigationByBinding
//
//  Created by Munavar PM on 13/01/25.
//

import SwiftUI

struct ContentView: View {
    @State var isDownRoot: Bool = false
    @State var toRoot: Bool = false
    @State var setRoot: Bool = false
    var body: some View {
        if !setRoot {
            NavigationView {
                LoginView(isDownRoot: $isDownRoot, toRoot: $toRoot, setRoot: $setRoot)
            }
        } else {
            NavigationView {
                HomeView(isDownRoot: $isDownRoot, isSetRoot: $setRoot)
            }
        }
    }
}

#Preview {
    ContentView()
}

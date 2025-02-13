//
//  HomeView.swift
//  NavigationByBinding
//
//  Created by Munavar PM on 13/01/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isNavigateViewOne = false
    @Environment(\.dismiss) var dismiss
    @Binding var isDownRoot: Bool
    @State var toRoot: Bool = false
    @Binding var isSetRoot: Bool
    var body: some View {
        ZStack {
            NavigationLink("", destination: ViewOne(toRoot: $toRoot, setRoot: $isSetRoot).navigationBarBackButtonHidden(true), isActive: $toRoot)
            VStack {
                Image(systemName: "house.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Button("Hey, welcome to Navigation By Binding!") {
                    self.toRoot = true
                    self.isDownRoot = false /// When i was make this as false it will indicate loginScreen
                }
            }
        }
        .onAppear {
            print("HomeView Root Condition: - \(toRoot)")
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                print("HomeView DownRoot Condition : - \(isDownRoot)")
                self.isSetRoot = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    HomeView(isDownRoot: .constant(false), toRoot: .constant(false), isSetRoot: .constant(false))
//}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

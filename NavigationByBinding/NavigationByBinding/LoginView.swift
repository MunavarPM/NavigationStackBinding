//
//  LoginView.swift
//  NavigationByBinding
//
//  Created by Munavar PM on 13/01/25.
//

import SwiftUI

struct LoginView: View {
    @State private var isUserName: String = ""
    @State private var isPassword: String = ""
    
    @State var isNavigateToOTPView = false
    
    @Binding var isDownRoot: Bool
    @Binding var toRoot: Bool
    
    @Binding var setRoot: Bool
    
    var body: some View {
        VStack {
            TextField("Username", text: $isUserName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $isPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            NavigationLink(destination: OTPView(isDownRoot: self.$isDownRoot, toRoot: self.$toRoot, setRoot: $setRoot).navigationBarBackButtonHidden(true), isActive: self.$isDownRoot) {
                ButtonComponent {
                    HStack {
                        Text("Login")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.black)
                    }
                } action: {
                    if isUserName == "1" && isPassword == "1" {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            isDownRoot = true
                            print("isDownRoot Condition in LoginView :- \(isDownRoot)")
                        }
                        return .success
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            print("Invalid credentials")
                        }
                        return .faild("Invalid credentials")
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .isDetailLink(false)
        }
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    LoginView(isDownRoot: .constant(false), toRoot: .constant(false))
//}

struct ButtonComponent<ButtonContent: View>: View {
    var content: () -> ButtonContent
    var action: () async -> TaskStatus
    @State private var isLoading: Bool = false
    @State private var takeStatus: TaskStatus = .idle
    @State private var isFailed: Bool = false
    @State private var showPopup: Bool = false
    @State private var popupMessage: String = ""
    @State private var isWiggle: Bool = false
    var body: some View {
        Button {
            Task {
                isLoading = true
                let taskStatus = await action()
                self.takeStatus = taskStatus
                switch takeStatus {
                case .idle:
                    isFailed = false
                case let .faild(string):
                    isFailed = true
                    popupMessage = string
                case .success:
                    isFailed = false
                }
                if isFailed {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        isWiggle.toggle()
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    if isFailed {
                        showPopup = true
                    }
                    self.takeStatus = .idle
                    isLoading = false
                }
            }
        } label: {
            content()
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .opacity(isLoading ? 0 : 1)
                .lineLimit(1)
                .frame(width: isLoading ? 50 : nil, height: isLoading ? 50 : nil)
                .background(
                    Color(takeStatus == .idle ? .white : takeStatus == .success ? .green : .red)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 2)
                )
                .overlay {
                    if isLoading && takeStatus == .idle {
                        ProgressView()
                    }
                }
                .overlay {
                    if takeStatus != .idle {
                        Image(systemName: isFailed ? "exclamationmark" : "checkmark")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                    }
                }
        }
        .disabled(isLoading)
        .animation(.snappy, value: isLoading)
        .animation(.snappy, value: takeStatus)
    }
}

enum TaskStatus: Equatable { // Equatable is help to check the status by == .
    case idle
    case faild(String)
    case success
}

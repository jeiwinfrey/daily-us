import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var showPhoneOption = false
    @State private var showPassword = false
    @FocusState private var isEmailFocused: Bool
    @State private var isBackPressed = false
    @State private var isPhonePressed = false
    @State private var isContinuePressed = false
    
    // Email validation computed property
    private var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top section with back button
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                        .scaleEffect(isBackPressed ? 0.85 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isBackPressed)
                        .onTapGesture {
                            dismiss()
                        }
                        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                            isBackPressed = pressing
                        }, perform: {})
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Main content
                VStack(spacing: 32) {
                    // Title
                    Text("What's your email?")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    // Email input section
                    VStack(spacing: 16) {
                        // Email input field
                        HStack {
                            TextField("Email address", text: $email)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.black)
                                .focused($isEmailFocused)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                            
                            if !email.isEmpty {
                                Button(action: {
                                    email = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 240/255, green: 152/255, blue: 177/255), lineWidth: isEmailFocused ? 2 : 0)
                        )
                        .padding(.horizontal, 24)
                    }
                }
                
                Spacer()
                
                // Bottom section
                VStack(spacing: 24) {
                    // Terms and privacy
                    VStack(spacing: 4) {
                        Text("By tapping Continue, you are agreeing to")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.black.opacity(0.6))
                        
                        HStack(spacing: 4) {
                            Text("our")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.black.opacity(0.6))
                            
                            Button(action: {
                                // Terms action
                            }) {
                                Text("Terms of Service")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(.black.opacity(0.8))
                                    .underline()
                            }
                            
                            Text("and")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.black.opacity(0.6))
                            
                            Button(action: {
                                // Privacy action
                            }) {
                                Text("Privacy Policy")
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(.black.opacity(0.8))
                                    .underline()
                            }
                        }
                    }
                    
                    // Continue button
                    HStack {
                        Text("Continue")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 240/255, green: 152/255, blue: 177/255))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scaleEffect(isContinuePressed ? 0.85 : 1.0)
                    .animation(.easeInOut(duration: 0.1), value: isContinuePressed)
                    .onTapGesture {
                        if isValidEmail {
                            showPassword = true
                        }
                    }
                    .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                        if isValidEmail {
                            isContinuePressed = pressing
                        }
                    }, perform: {})
                    .opacity(isValidEmail ? 1.0 : 0.5)
                    .padding(.horizontal, 24)
                }
                .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden)
        .tint(Color(red: 240/255, green: 152/255, blue: 177/255))
        .navigationDestination(isPresented: $showPassword) {
            EnterPasswordView()
        }
        .onAppear {
            // Auto-focus email field when view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isEmailFocused = true
            }
        }
    }
}

#Preview {
    SignUpView()
} 
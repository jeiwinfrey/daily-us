import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var password = ""
    @FocusState private var isPasswordFocused: Bool
    @State private var isBackPressed = false
    @State private var isContinuePressed = false
    @State private var isForgetPasswordPressed = false
    @State private var showResetPasswordModal = false
    
    // Password validation computed property
    private var isValidPassword: Bool {
        password.count >= 8
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
                
                Spacer()
                
                // Main content
                VStack(spacing: 24) {
                    // Title
                    Text("Choose a password")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    // Password input section
                    VStack(spacing: 16) {
                        // Password input field
                        HStack {
                            SecureField("Password", text: $password)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.black)
                                .focused($isPasswordFocused)
                                .autocorrectionDisabled()
                            
                            if !password.isEmpty {
                                Button(action: {
                                    password = ""
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
                                .stroke(Color(red: 240/255, green: 152/255, blue: 177/255), lineWidth: isPasswordFocused ? 2 : 0)
                        )
                        .padding(.horizontal, 24)
                        
                        // Forget password button
                        Text("Forgot password?")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.black.opacity(0.6))
                            .scaleEffect(isForgetPasswordPressed ? 0.85 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: isForgetPasswordPressed)
                            .onTapGesture {
                                showResetPasswordModal = true
                            }
                            .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                                isForgetPasswordPressed = pressing
                            }, perform: {})
                    }
                }
                
                Spacer()
                
                // Bottom section - copied exactly from SignInView
                VStack(spacing: 24) {
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
                        if isValidPassword {
                            // Continue action
                        }
                    }
                    .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                        if isValidPassword {
                            isContinuePressed = pressing
                        }
                    }, perform: {})
                    .opacity(isValidPassword ? 1.0 : 0.5)
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
        .sheet(isPresented: $showResetPasswordModal) {
            ResetPasswordModal(isPresented: $showResetPasswordModal)
        }
        .onAppear {
            // Auto-focus password field when view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPasswordFocused = true
            }
        }
    }
}

struct ResetPasswordModal: View {
    @Binding var isPresented: Bool
    @State private var isCancelPressed = false
    @State private var isResetPressed = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()

            VStack(spacing: 16) {
                // Title
                Text("Reset password?")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.top, 24)
                
                // Message
                Text("You will receive an email with instructions to reset your password.")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 12)
                
                // Buttons
                HStack(spacing: 12) {
                    // Cancel button
                    Text("Cancel")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.black.opacity(0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .scaleEffect(isCancelPressed ? 0.85 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isCancelPressed)
                        .onTapGesture {
                            isPresented = false
                        }
                        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                            isCancelPressed = pressing
                        }, perform: {})
                    
                    // Reset button
                    Text("Reset")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 240/255, green: 152/255, blue: 177/255))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .scaleEffect(isResetPressed ? 0.85 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isResetPressed)
                        .onTapGesture {
                            // Reset password action
                            isPresented = false
                        }
                        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                            isResetPressed = pressing
                        }, perform: {})
                }
            }
            .padding(.horizontal, 24)
        }
        .background(Color.white)
        .presentationDetents([.fraction(0.25)])
        .presentationCornerRadius(40)
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    CreatePasswordView()
} 

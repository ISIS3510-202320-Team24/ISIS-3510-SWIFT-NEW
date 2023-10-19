import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var nextScreen: String? = nil
    @Published var emailText: String = ""
    @Published var isValidEmailText: Bool = true
    @Published var passwordText: String = ""
    @Published var isValidPasswordText: Bool = true
    @Published var showError = false
}

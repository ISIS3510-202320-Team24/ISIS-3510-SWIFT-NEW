import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var nextScreen: String? = nil
    @Published var tamdcText: String = ""
    @Published var isValidTamdcText: Bool = true
    @Published var usernameText: String = ""
    @Published var isValidUsernameText: Bool = true
    @Published var rowflagofcolombiText: String = ""
    @Published var isValidRowflagofcolombiText: Bool = true
    @Published var mailText: String = ""
    @Published var isValidMailText: Bool = true
    @Published var passwordText: String = ""
    @Published var isValidPasswordText: Bool = true
    @Published var cnpaswordText: String = ""
    @Published var isValidCnpaswordText: Bool = true
    @Published var iaccepttheprCheckbox: Bool = false
    @Published var selectedCarrera: String = "Select your degree"
    var allFieldsValid: Bool {
        return isValidTamdcText && isValidUsernameText && isValidRowflagofcolombiText && isValidMailText && isValidPasswordText && isValidCnpaswordText && iaccepttheprCheckbox && rowflagofcolombiText.count==10 && passwordText==cnpaswordText
    }
    
}

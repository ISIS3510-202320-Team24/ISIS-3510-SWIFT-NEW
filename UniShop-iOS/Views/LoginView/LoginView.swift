import SwiftUI

struct UserLog: Codable {
    let degree: String?
    let email: String
    let id: String
    let name: String
    let password: String
    let phone: String
    let username: String
}

struct UsersResponseLog: Codable {
    let users: [UserLog]
}

struct LoginView: View {
    @State private var showError = false
    @State private var navigateToSignUp = false
    @State private var navigateToHome = false
    @StateObject var loginViewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode:
    Binding<PresentationMode>
    
    func signUp() {
        
        guard !loginViewModel.emailText.isEmpty, !loginViewModel.passwordText.isEmpty else {
                print("El nombre de usuario y la contraseña no pueden estar vacíos")
                return
            }
        // Ensure your URL is correct.
        guard let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/users/all") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                // Aquí puedes mostrar el mensaje de error
                loginViewModel.showError = true // Paso 2
                return
            }
            
            do {
                let usersResponse = try JSONDecoder().decode(UsersResponseLog.self, from: data)
                print("Decoding successful: \(usersResponse)")
                
                if let user = usersResponse.users.first(where: { $0.email == loginViewModel.emailText && $0.password == loginViewModel.passwordText }) {
                    print("User found: \(user)")
                    navigateToHome = true
                    saveUserLocally(user: user)
                } else {
                    print(loginViewModel.emailText)
                    print(loginViewModel.passwordText)
                    print("Invalid credentials")
                    // Aquí puedes mostrar el mensaje de error
                    loginViewModel.showError = true // Paso 2
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
                if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                    switch decodingError {
                    case .keyNotFound(let key, _):
                        print("Key not found: \(key)")
                    case .valueNotFound(let type, _):
                        print("Value not found for type: \(type)")
                    case .typeMismatch(let type, _):
                        print("Type mismatch for type: \(type)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
                print(String(data: data, encoding: .utf8) ?? "Data could not be printed")
                // Aquí puedes mostrar el mensaje de error
                loginViewModel.showError = true // Paso 2
            }
        }
        
        task.resume()
    }
    
    func saveUserLocally(user: UserLog) {
        let defaults = UserDefaults.standard
        defaults.set(user.id, forKey: "userID")
        defaults.set(user.email, forKey: "userEmail")
        defaults.set(user.name, forKey: "userName")
        defaults.set(user.username, forKey: "username")
        defaults.set(user.phone, forKey: "userPhone")
        defaults.set(user.degree, forKey: "userDegree")
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    ZStack {
                        VStack {
                            ZStack(alignment: .topTrailing) {
                                Image("img_ellipse48_152x390")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width,
                                           height: getRelativeHeight(152.0), alignment: .center)
                                    .scaledToFit()
                                    .clipped()
                                    .offset(y: -getRelativeHeight(100))
                                HStack {
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack {
                                            HStack {
                                                Text(StringConstants.kLblLoginAccount)
                                                    .font(FontScheme
                                                        .kOutfitSemiBold(size: getRelativeHeight(24.0)))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.black)
                                                    .minimumScaleFactor(0.5)
                                                    .multilineTextAlignment(.leading)
                                                    .frame(width: getRelativeWidth(153.0),
                                                           height: getRelativeHeight(31.0),
                                                           alignment: .topLeading)
                                                Spacer()
                                                Image("img_user")
                                                    .resizable()
                                                    .frame(width: getRelativeWidth(16.0),
                                                           height: getRelativeHeight(15.0),
                                                           alignment: .center)
                                                    .scaledToFit()
                                                    .clipped()
                                                    .padding(.top, getRelativeHeight(6.0))
                                                    .padding(.bottom, getRelativeHeight(8.0))
                                            }
                                            .frame(width: getRelativeWidth(178.0),
                                                   height: getRelativeHeight(31.0), alignment: .leading)
                                        }
                                        .frame(width: getRelativeWidth(178.0),
                                               height: getRelativeHeight(31.0), alignment: .leading)
                                        Text(StringConstants.kMsgYouReAtUnian)
                                            .font(FontScheme.kOutfitRegular(size: getRelativeHeight(13.0)))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color.black)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: getRelativeWidth(180.0),
                                                   height: getRelativeHeight(17.0), alignment: .topLeading)
                                    }
                                    .frame(width: getRelativeWidth(180.0), height: getRelativeHeight(50.0),
                                           alignment: .top)
                                    ZStack(alignment: .topTrailing) {
                                        Image("img_ellipse47_123x183")
                                            .resizable()
                                            .frame(width: getRelativeWidth(183.0),
                                                   height: getRelativeHeight(123.0), alignment: .center)
                                            .scaledToFit()
                                            .clipped()
                                            .offset(y: -getRelativeHeight(100))
                                        HStack {
                                            Image("img_image1")
                                                .resizable()
                                                .frame(width: getRelativeWidth(50),
                                                       height: getRelativeHeight(50), alignment: .center)
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .clipShape(Capsule())
                                                .offset(x: -getRelativeWidth(30))
                                                .offset(y: -getRelativeHeight(-40))
                                            Image("img_shape")
                                                .resizable()
                                                .frame(width: getRelativeWidth(9.0),
                                                       height: getRelativeHeight(6.0), alignment: .center)
                                                .scaledToFit()
                                                .clipped()
                                                .padding(.leading, getRelativeWidth(10.0))
                                                .offset(x: -getRelativeWidth(30))
                                                .offset(y: -getRelativeHeight(-40))
                                        }
                                        .frame(width: getRelativeWidth(60.0),
                                               height: getRelativeHeight(39.0), alignment: .topTrailing)
                                        .padding(.bottom, getRelativeHeight(75.0))
                                        .padding(.leading, getRelativeWidth(104.0))
                                    }
                                    .hideNavigationBar()
                                    .frame(width: getRelativeWidth(183.0), height: getRelativeHeight(123.0),
                                           alignment: .center)
                                    .padding(.leading, getRelativeWidth(4.0))
                                }
                                .frame(width: getRelativeWidth(367.0), height: getRelativeHeight(123.0),
                                       alignment: .topTrailing)
                                .padding(.bottom, getRelativeHeight(29.0))
                                .padding(.leading, getRelativeWidth(23.0))
                            }
                            .hideNavigationBar()
                            .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(152.0),
                                   alignment: .leading)
                            Text(StringConstants.kLblUniShop)
                                .font(FontScheme.kOutfitMedium(size: getRelativeHeight(60.0)))
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .frame(width: getRelativeWidth(241.0), height: getRelativeHeight(60.0),
                                       alignment: .topLeading)
                                .padding(.horizontal, getRelativeWidth(61.0))
                            Group {
                                HStack {
                                    TextField(StringConstants.kMsgInstitutionalE,
                                              text: $loginViewModel.emailText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(.black)
                                    .padding()
                                }
                                .onChange(of: loginViewModel.emailText) { newValue in
                                    
                                    loginViewModel.isValidEmailText = newValue
                                        .isValidEmail(isMandatory: true)
                                }
                                .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                                       alignment: .center)
                                .overlay(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                        bottomRight: 8.0)
                                    .stroke(Color.gray,
                                            lineWidth: 1))
                                .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                           bottomRight: 8.0)
                                    .fill(Color.clear.opacity(0.7)))
                                .padding(.top, getRelativeHeight(44.0))
                                .padding(.horizontal, getRelativeWidth(29.0))
                                
                            }
                            Group {
                                HStack {
                                    SecureField(StringConstants.kLblPassword,
                                                text: $loginViewModel.passwordText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(.black)
                                    .padding()
                                    .keyboardType(.default)
                                }
                                .onChange(of: loginViewModel.passwordText) { newValue in
                                    
                                    loginViewModel.isValidPasswordText = newValue
                                        .isValidPassword(isMandatory: true)
                                }
                                .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                                       alignment: .center)
                                .overlay(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                        bottomRight: 8.0)
                                    .stroke(Color.gray,
                                            lineWidth: 1))
                                .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                           bottomRight: 8.0)
                                    .fill(Color.clear.opacity(0.7)))
                                .padding(.top, getRelativeHeight(11.0))
                                .padding(.horizontal, getRelativeWidth(29.0))
                                
                            }
                            Text(StringConstants.kMsgForgetPassword)
                                .font(FontScheme.kOutfitRegular(size: getRelativeHeight(13.0)))
                                .fontWeight(.regular)
                                .foregroundColor(Color.black)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .frame(width: getRelativeWidth(107.0), height: getRelativeHeight(17.0),
                                       alignment: .topLeading)
                                .padding(.top, getRelativeHeight(5.0))
                                .padding(.horizontal, getRelativeWidth(33.0))
                            Button(action: {
                                signUp()
                            }, label: {
                                HStack(spacing: 0) {
                                    Text(StringConstants.kLblLogin2)
                                        .font(FontScheme.kOutfitRegular(size: getRelativeHeight(18.0)))
                                        .fontWeight(.regular)
                                        .padding(.horizontal, getRelativeWidth(30.0))
                                        .padding(.vertical, getRelativeHeight(12.0))
                                        .foregroundColor(Color.black)
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .frame(width: getRelativeWidth(328.0),
                                               height: getRelativeHeight(48.0), alignment: .center)
                                        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0,
                                                                   bottomLeft: 8.0, bottomRight: 8.0)
                                            .fill(Color(red: 1, green: 0.776, blue: 0)))
                                        .padding(.horizontal, getRelativeWidth(29.0))
                                    NavigationLink(destination: ContentView(), isActive: $navigateToHome) {
                                        EmptyView()
                                    }
                                }
                            })
                            .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                                   alignment: .center)
                            .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                       bottomRight: 8.0)
                                .fill(Color.yellow))
                            .padding(.top, getRelativeHeight(23.0))
                            .padding(.horizontal, getRelativeWidth(29.0))
                            if loginViewModel.showError {
                                Text("Correo o contraseña incorrectos.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0), alignment: .center)
                            }
                            HStack {
                                Divider()
                                    .frame(width: getRelativeWidth(105.0), height: (1.0),
                                           alignment: .bottom)
                                    .background(Color.black)
                                    .padding(.top, getRelativeHeight(9.0))
                                    .padding(.bottom, getRelativeHeight(6.0))
                                Text(StringConstants.kLblOrSignUpWith)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(12.0)))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.black)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: getRelativeWidth(80.0), height: getRelativeHeight(16.0),
                                           alignment: .topLeading)
                                    .padding(.leading, getRelativeWidth(4.0))
                                Divider()
                                    .frame(width: getRelativeWidth(105.0), height: getRelativeHeight(1.0),
                                           alignment: .bottom)
                                    .background(Color.black)
                                    .padding(.top, getRelativeHeight(9.0))
                                    .padding(.bottom, getRelativeHeight(6.0))
                                    .padding(.leading, getRelativeWidth(4.0))
                                Spacer()
                            }
                            .frame(width: getRelativeWidth(298.0), height: getRelativeHeight(16.0),
                                   alignment: .center)
                            .padding(.top, getRelativeHeight(35.0))
                            .padding(.horizontal, getRelativeWidth(29.0))
                            ZStack {
                                Image("img_image1_34x35")
                                    .resizable()
                                    .frame(width: getRelativeWidth(35.0), height: getRelativeHeight(34.0),
                                           alignment: .center)
                                    .scaledToFit()
                                    .clipped()
                                    .padding(.vertical, getRelativeHeight(7.0))
                                    .padding(.horizontal, getRelativeWidth(26.0))
                            }
                            .hideNavigationBar()
                            .frame(width: getRelativeWidth(88.0), height: getRelativeHeight(48.0),
                                   alignment: .center)
                            .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                       bottomRight: 8.0)
                                .fill(Color.white))
                            .shadow(color: Color.black, radius: 1, x: 0, y: 1)
                            .padding(.top, getRelativeHeight(33.0))
                            .padding(.horizontal, getRelativeWidth(29.0))
                            NavigationLink(destination: SignUpView(), isActive: $navigateToSignUp) {
                                EmptyView()
                            }
                            Text(StringConstants.kMsgNotRegisterYe)
                                .font(FontScheme.kPoppinsRegular(size: getRelativeHeight(13.0)))
                                .fontWeight(.regular)
                                .foregroundColor(Color.blue) // Cambia el color a azul
                                .underline(true, color: Color.blue) // Agrega la línea azul
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .frame(width: getRelativeWidth(193.0), height: getRelativeHeight(20.0),
                                       alignment: .topLeading)
                                .padding(.top, getRelativeHeight(52.0))
                                .padding(.horizontal, getRelativeWidth(29.0))
                                .onTapGesture {
                                    self.navigateToSignUp = true
                                }
                            
                            
                        }
                        .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(694.0),
                               alignment: .topLeading)
                    }
                    .hideNavigationBar()
                    .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                    .background(Color.white)
                    .padding(.top, getRelativeHeight(30.0))
                    .padding(.bottom, getRelativeHeight(10.0))
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color.white)
                .ignoresSafeArea()
            }
        }
        .hideNavigationBar()
        .gesture(DragGesture().onChanged { _ in })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


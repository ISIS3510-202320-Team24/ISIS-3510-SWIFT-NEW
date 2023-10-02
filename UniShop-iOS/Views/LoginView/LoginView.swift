import SwiftUI

struct LoginView: View {
    // Función para realizar la solicitud de registro (SignUp)
    func signUp() {
        // Define la URL de la solicitud SignUp
        let signUpURL = URL(string: "https://creative-mole-46.hasura.app/api/rest/users/signup")!

        // Define el cuerpo de la solicitud como un diccionario JSON
        let signUpData: [String: Any] = [
            "object": [
                "email": loginViewModel.emailText,
                "name": "Test User",
                "password": loginViewModel.passwordText,
                "phone": "123-456-78904",
                "username": "testuser4"
            ]
        ]

        // Convierte el diccionario en datos JSON
        guard let signUpJSON = try? JSONSerialization.data(withJSONObject: signUpData) else {
            return
        }

        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")
        request.httpBody = signUpJSON

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    // Procesa la respuesta JSON
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Maneja la respuesta aquí
                        if let users = json["users"] as? [Any], users.isEmpty {
                            // No se encontraron usuarios, manejarlo aquí (respuesta vacía)
                            print("No users found")
                        } else {
                            // Se encontraron usuarios, manejarlos aquí
                            print("Users found")
                            // Marca al usuario como logueado
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            DispatchQueue.main.async {
                                navigateToNewPost = true
                            }
                        }
                    }
                } else if let error = error {
                    // Maneja el error, por ejemplo, muestra un mensaje de error al usuario
                    print("SignUp Error: \(error)")
                }
            }.resume()
        }


    @State private var navigateToSignUp = false
    @State private var navigateToNewPost = false
    @StateObject var loginViewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode:
    Binding<PresentationMode>
    var body: some View {
        NavigationView {
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
                                                .foregroundColor(.black)
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
                                        .foregroundColor(.black)
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
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(241.0), height: getRelativeHeight(76.0),
                                   alignment: .topLeading)
                            .padding(.top, getRelativeHeight(15.0))
                            .padding(.horizontal, getRelativeWidth(61.0))
                        Group {
                            HStack {
                                TextField(StringConstants.kMsgInstitutionalE,
                                          text: $loginViewModel.emailText)
                                .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                .foregroundColor(ColorConstants.Gray700)
                                .padding()
                                .keyboardType(.emailAddress)
                            }
                            .onChange(of: loginViewModel.emailText) { newValue in
                                
                                loginViewModel.isValidEmailText = newValue
                                    .isValidEmail(isMandatory: true)
                            }
                            .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                                   alignment: .center)
                            .overlay(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                    bottomRight: 8.0)
                                .stroke(ColorConstants.Gray701,
                                        lineWidth: 1))
                            .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                       bottomRight: 8.0)
                                .fill(Color.clear.opacity(0.7)))
                            .padding(.top, getRelativeHeight(44.0))
                            .padding(.horizontal, getRelativeWidth(29.0))
                            if !loginViewModel.isValidEmailText {
                                Text("Please enter valid email.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        Group {
                            HStack {
                                SecureField(StringConstants.kLblPassword,
                                            text: $loginViewModel.passwordText)
                                .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                .foregroundColor(ColorConstants.Gray700)
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
                                .stroke(ColorConstants.Gray701,
                                        lineWidth: 1))
                            .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                       bottomRight: 8.0)
                                .fill(Color.clear.opacity(0.7)))
                            .padding(.top, getRelativeHeight(11.0))
                            .padding(.horizontal, getRelativeWidth(29.0))
                            if !loginViewModel.isValidPasswordText {
                                Text("Please enter valid password.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        Text(StringConstants.kMsgForgetPassword)
                            .font(FontScheme.kOutfitRegular(size: getRelativeHeight(13.0)))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(107.0), height: getRelativeHeight(17.0),
                                   alignment: .topLeading)
                            .padding(.top, getRelativeHeight(5.0))
                            .padding(.horizontal, getRelativeWidth(33.0))
                        Button(action: signUp) {
                            Text("Sign Up")
                                .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0))
                                .background(
                                    RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
                                        .fill(Color(red: 1, green: 0.776, blue: 0))
                                )
                                .padding(.horizontal, getRelativeWidth(29.0))
                        }
                        .padding(.top, getRelativeHeight(23.0))
                        .padding(.horizontal, getRelativeWidth(29.0))

                        HStack {
                            Divider()
                                .frame(width: getRelativeWidth(105.0), height: 1.0)
                                .background(ColorConstants.Gray500)
                                .padding(.top, getRelativeHeight(9.0))
                                .padding(.bottom, getRelativeHeight(6.0))
                            Text(StringConstants.kLblOrSignUpWith)
                                .font(FontScheme.kOutfitRegular(size: getRelativeHeight(12.0)))
                                .fontWeight(.regular)
                                .foregroundColor(ColorConstants.Gray600)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .frame(width: getRelativeWidth(80.0), height: getRelativeHeight(16.0))
                                .padding(.leading, getRelativeWidth(4.0))
                            Divider()
                                .frame(width: getRelativeWidth(105.0), height: getRelativeHeight(1.0))
                                .background(ColorConstants.Gray500)
                                .padding(.top, getRelativeHeight(9.0))
                                .padding(.bottom, getRelativeHeight(6.0))
                                .padding(.leading, getRelativeWidth(4.0))
                            Spacer()
                        }
                        .frame(width: getRelativeWidth(298.0), height: getRelativeHeight(16.0))
                        .padding(.top, getRelativeHeight(35.0))
                        .padding(.horizontal, getRelativeWidth(29.0))

                        ZStack {
                            Image("img_image1_34x35")
                                .resizable()
                                .frame(width: getRelativeWidth(35.0), height: getRelativeHeight(34.0))
                                .scaledToFit()
                                .clipped()
                                .padding(.vertical, getRelativeHeight(7.0))
                                .padding(.horizontal, getRelativeWidth(26.0))
                        }

                        .hideNavigationBar()
                        .frame(width: getRelativeWidth(88.0), height: getRelativeHeight(48.0), alignment: .center)
                        .background(
                            RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
                                .fill(Color.white)
                        )
                        .shadow(color: .black, radius: 1, x: 0, y: 1)
                        .padding(.top, getRelativeHeight(33.0))
                        .padding(.leading, getRelativeWidth(29.0))
                        .padding(.trailing, getRelativeWidth(29.0))

                        NavigationLink(destination: SignUpView(), isActive: $navigateToSignUp) {
                            EmptyView()
                        }

                        Text(StringConstants.kMsgNotRegisterYe)
                            .font(FontScheme.kPoppinsRegular(size: getRelativeHeight(13.0)))
                            .fontWeight(.regular)
                            .foregroundColor(ColorConstants.Gray702)
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
                .background(ColorConstants.WhiteA700)
                .padding(.top, getRelativeHeight(30.0))
                .padding(.bottom, getRelativeHeight(10.0))
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorConstants.WhiteA700)
            .ignoresSafeArea()
        }
        .hideNavigationBar()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

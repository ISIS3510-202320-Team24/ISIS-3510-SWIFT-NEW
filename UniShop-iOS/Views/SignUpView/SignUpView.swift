import SwiftUI
struct SignUpView: View {
    @State private var navigateToLogin = false
    @StateObject var signUpViewModel = SignUpViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack(alignment: .trailing) {
                            Image("img_ellipse48_amber_a400")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width,
                                       height: getRelativeHeight(134.0), alignment: .center)
                                .scaledToFit()
                                .clipped()
                                .offset(y: -getRelativeHeight(35))
                            ZStack(alignment: .topLeading) {
                                ZStack(alignment: .topTrailing) {
                                    Image("img_ellipse47_132x183")
                                        .resizable()
                                        .frame(width: getRelativeWidth(183.0),
                                               height: getRelativeHeight(132.0), alignment: .center)
                                        .scaledToFit()
                                        .clipped()
                                        .offset(y: -getRelativeHeight(35))
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
                                                   height: getRelativeHeight(6.0),
                                                   alignment: .center)
                                            .scaledToFit()
                                            .clipped()
                                            .padding(.leading, getRelativeWidth(10.0))
                                            .offset(x: -getRelativeWidth(30))
                                            .offset(y: -getRelativeHeight(-40))
                                    }
                                    .frame(width: getRelativeWidth(60.0),
                                           height: getRelativeHeight(39.0), alignment: .topTrailing)
                                    .padding(.bottom, getRelativeHeight(84.0))
                                    .padding(.leading, getRelativeWidth(104.0))
                                }
                                .hideNavigationBar()
                                .frame(width: getRelativeWidth(183.0),
                                       height: getRelativeHeight(132.0), alignment: .trailing)
                                .padding(.leading, getRelativeWidth(178.0))
                                Text(StringConstants.kLblUniShop)
                                    .font(FontScheme.kOutfitMedium(size: getRelativeHeight(60.0)))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: getRelativeWidth(241.0),
                                           height: getRelativeHeight(76.0), alignment: .topLeading)
                                    .padding(.bottom, getRelativeHeight(40.63))
                                    .padding(.trailing, getRelativeWidth(120.0))
                                    .offset(y: -getRelativeHeight(-40))
                            }
                            .hideNavigationBar()
                            .frame(width: getRelativeWidth(361.0), height: getRelativeHeight(132.0),
                                   alignment: .trailing)
                            .padding(.leading, getRelativeWidth(29.0))
                        }
                        .hideNavigationBar()
                        .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(134.0),
                               alignment: .leading)
                        Text(StringConstants.kMsgWelcomeToUnis)
                            .font(FontScheme.kOutfitRegular(size: getRelativeHeight(24.0)))
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(217.0), height: getRelativeHeight(31.0),
                                   alignment: .topLeading)
                            .padding(.top, getRelativeHeight(9.0))
                            .padding(.horizontal, getRelativeWidth(31.0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(174.0),
                           alignment: .leading)
                    VStack {
                        Group {
                            HStack {
                                TextField(StringConstants.kLblName,
                                          text: $signUpViewModel.tamdcText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .keyboardType(.alphabet)
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
                            if !signUpViewModel.isValidTamdcText {
                                Text("Please enter valid text.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        Group {
                            HStack {
                                TextField(StringConstants.kLblUsername,
                                          text: $signUpViewModel.usernameText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(ColorConstants.Gray700)
                                    .padding()
                                    .keyboardType(.alphabet)
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
                            if !signUpViewModel.isValidUsernameText {
                                Text("Please enter valid text.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        Group {
                            HStack {
                                Spacer()
                                Image("img_flagofcolombi")
                                    .resizable()
                                    .frame(width: getRelativeWidth(25.0),
                                           height: getRelativeHeight(17.0), alignment: .center)
                                    .scaledToFit()
                                    .clipped()
                                    .padding(.top, getRelativeHeight(15.0))
                                    .padding(.bottom, getRelativeHeight(16.0))
                                    .padding(.leading, getRelativeWidth(15.0))
                                TextField(StringConstants.kLblPhone,
                                          text: $signUpViewModel.rowflagofcolombiText)
                                .foregroundColor(ColorConstants.Gray700)
                                    .font(.system(size: 16))
                                    .padding()
                                    .keyboardType(.phonePad)
                                    .onReceive(signUpViewModel.rowflagofcolombiText.publisher.collect()) {
                                            let filtered = String($0.prefix(10))
                                            if signUpViewModel.rowflagofcolombiText != filtered {
                                                signUpViewModel.rowflagofcolombiText = filtered
                                            }
                                        }
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
                            if !signUpViewModel.isValidRowflagofcolombiText {
                                Text("Please enter valid phone number.")
                                    .foregroundColor(Color.red)
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        Group {
                            HStack {
                                TextField(StringConstants.kLblEmail,
                                          text: $signUpViewModel.mailText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(ColorConstants.Gray700)
                                    .padding()
                                    .keyboardType(.emailAddress)
                            }
                            .onChange(of: signUpViewModel.mailText) { newValue in
                                signUpViewModel.isValidMailText = newValue
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
                            .padding(.top, getRelativeHeight(11.0))  // Adjusted padding to match other fields
                            .padding(.horizontal, getRelativeWidth(29.0))  // Adjusted padding to match other fields
                            if !signUpViewModel.isValidMailText {
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
                                            text: $signUpViewModel.passwordText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(ColorConstants.Gray700)
                                    .padding()
                                    .keyboardType(.default)
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
                            if !signUpViewModel.isValidPasswordText {
                                Text("Please enter valid password.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        Group {
                            HStack {
                                SecureField(StringConstants.kMsgConfirmPasswor,
                                            text: $signUpViewModel.cnpaswordText)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .foregroundColor(ColorConstants.Gray700)
                                    .padding()
                                    .keyboardType(.default)
                            }
                            .onChange(of: signUpViewModel.cnpaswordText) { newValue in

                                signUpViewModel.isValidCnpaswordText = newValue
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
                            if !signUpViewModel.isValidCnpaswordText {
                                Text("Please enter valid password.")
                                    .foregroundColor(Color.red)
                                    .font(FontScheme.kOutfitRegular(size: getRelativeHeight(15.0)))
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                            }
                        }
                        HStack{
                           
                            Group {
                                Picker("Selecciona tu carrera", selection: $signUpViewModel.selectedCarrera) {
                                    ForEach(["ISIS", "MATE", "ADMIN", "IIND", "ARQUI", "ARTE", "DISE"], id: \.self) { carrera in
                                        Text(carrera).tag(carrera)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                                       alignment: .leading )
                                .padding(.top, getRelativeHeight(11.0))
                                .padding(.horizontal, getRelativeWidth(29.0))
                                .offset(x: -getRelativeHeight(-12))
                                .foregroundColor(ColorConstants.Gray700)

                            }; Spacer()}
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(401.0),
                           alignment: .leading)
                    VStack(alignment: .leading, spacing: 0) {
                        CheckboxField(idValue: StringConstants.kMsgIAcceptThePr,
                                      label: StringConstants.kMsgIAcceptThePr,
                                      color: Color.black,
                                      isMarked: $signUpViewModel.iaccepttheprCheckbox)
                            .minimumScaleFactor(0.5)
                            .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                                   alignment: .leading)
                            .overlay(RoundedCorners().stroke(Color.black, lineWidth: 1))
                            .background(RoundedCorners().fill(Color.yellow))
                            .padding(.horizontal, getRelativeWidth(30.0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(47.0),
                           alignment: .leading)
                    .padding(.top, getRelativeHeight(28.0))
                    VStack {
                        Button(action: {
                            if signUpViewModel.allFieldsValid {
        
                                let userData: [String: Any] = [
                                    "object": [
                                        "email": signUpViewModel.mailText,
                                        "name": signUpViewModel.tamdcText,
                                        "password": signUpViewModel.passwordText,
                                        "phone": signUpViewModel.rowflagofcolombiText,
                                        "username": signUpViewModel.usernameText,
                                        "degree":
                                        signUpViewModel.selectedCarrera
                                    ]
                                ]
                            

                                // Convertir el diccionario en datos JSON
                                if let jsonData = try?
                                    JSONSerialization.data(withJSONObject: userData) {

                                    // Crear la URL para la solicitud POST
                                    if let url = URL(string: "https://creative-mole-46.hasura.app/api/rest/users/signup") {

                                        var request = URLRequest(url: url)
                                        request.httpMethod = "POST"

                                        // Establecer el encabezado de la solicitud
                                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                        request.addValue("mmjEW9L3cf3SZ0cr5pb6hnnnFp1ud4CB4M6iT1f0xYons16k2468G9SqXS9KgdAZ", forHTTPHeaderField: "x-hasura-admin-secret")

                                        // Establecer el cuerpo de la solicitud
                                        request.httpBody = jsonData

                                        // Realizar la solicitud
                                        URLSession.shared.dataTask(with: request) { data, response, error in
                                            if let data = data {
                                                print("1")
                                                // Analizar la respuesta JSON
                                                if let json = try?
                                                   
                                                    JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                                    print("2")
                                                    // Verificar si la respuesta indica un registro exitoso o no
                                                    if true {
                                                        print("3")
                                                        self.navigateToLogin = true
                                                        self.signUpViewModel.nextScreen = "LoginView"
                                                        print("Registro exitoso")
                                                    }
                                                    if let dataResponse = json["data"] as? [String: Any], let _ = dataResponse["insert_users_one"] as? [String: Any] {
                                                        print("3")
                                                        // Registro exitoso, redirige al usuario a la vista de inicio de sesión
                                                        self.navigateToLogin = true
                                                        self.signUpViewModel.nextScreen = "LoginView"
                                                        print("Registro exitoso")
                                                   
                                                    } else if let errors = json["errors"] as? [[String: Any]] {
                                                        print("4")
                                                        for error in errors {
                                                            if let message = error["message"] as? String {
                                                                print("Error: \(message)")
                                                            }
                                                        }
                                                    }
                                                }
                                            } else if let error = error {
                                                print("Error en la solicitud: \(error.localizedDescription)")
                                            }
                                        }.resume()
                                    }
                                }
                            }
                        }) {
                            // Botón de registro
                            Text(StringConstants.kLblSignUp)
                                .font(FontScheme.kOutfitRegular(size: getRelativeHeight(18.0)))
                                .fontWeight(.regular)
                                .padding(.horizontal, getRelativeWidth(30.0))
                                .padding(.vertical, getRelativeHeight(12.0))
                                .foregroundColor(Color.black)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0), alignment: .center)
                                .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
                                    .fill(Color.yellow))
                                .padding(.horizontal, getRelativeWidth(29.0))
                        }
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                               alignment: .center)
                        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                   bottomRight: 8.0)
                            .fill(Color.yellow))
                        .padding(.horizontal, getRelativeWidth(29.0))
                        NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                            EmptyView()
                        }
                        Text(StringConstants.kMsgAlreadyHaveAn)
                            .font(FontScheme.kPoppinsRegular(size: getRelativeHeight(13.0)))
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(194.0), height: getRelativeHeight(20.0),
                                   alignment: .topLeading)
                            .padding(.top, getRelativeHeight(21.0))
                            .padding(.horizontal, getRelativeWidth(29.0))
                            .onTapGesture {
                                self.navigateToLogin = true
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(89.0),
                           alignment: .leading)
                    .padding(.top, getRelativeHeight(26.0))
                    .padding(.bottom, getRelativeHeight(29.0))
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .background(Color.white)
                .padding(.top, getRelativeHeight(30.0))
                .padding(.bottom, getRelativeHeight(10.0))
                Group {
                    NavigationLink(destination: LoginView(),
                                   tag: "LoginView",
                                   selection: $signUpViewModel.nextScreen,
                                   label: {
                                       EmptyView()
                                   })
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorConstants.WhiteA700)
            .ignoresSafeArea()
            .hideNavigationBar()
        }
        .hideNavigationBar()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


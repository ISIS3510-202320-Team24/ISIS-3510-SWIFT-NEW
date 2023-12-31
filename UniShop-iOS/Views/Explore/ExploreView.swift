import SwiftUI


struct ExploreView: View {
    @StateObject var exploreViewModel = ExploreViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var networkManager: NetworkManager
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack(alignment: .center) {
                            ZStack(alignment: .topTrailing) {
                                Image("img_ellipse48")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width,
                                           height: getRelativeHeight(152.0), alignment: .center)
                                    .scaledToFit()
                                    .clipped()
                                    .offset(y: -getRelativeHeight(35))
                                Image("img_ellipse47")
                                    .resizable()
                                    .frame(width: getRelativeWidth(183.0),
                                           height: getRelativeHeight(123.0), alignment: .center)
                                    .scaledToFit()
                                    .clipped()
                                    .padding(.bottom, getRelativeHeight(29.0))
                                    .padding(.leading, getRelativeWidth(207.0))
                                    .offset(y: -getRelativeHeight(35))
                            }
                            .hideNavigationBar()
                            .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(152.0),
                                   alignment: .topLeading)
                            .padding(.bottom, getRelativeHeight(280.0))
                            Image("img_group")
                                .resizable()
                                .frame(width: getRelativeWidth(319.0), height: getRelativeHeight(365.0),
                                       alignment: .center)
                                .scaledToFit()
                                .clipped()
                                .padding(.top, getRelativeHeight(67.0))
                                .padding(.leading, getRelativeWidth(31.99))
                                .padding(.trailing, getRelativeWidth(39.01))
                        }
                        .hideNavigationBar()
                        .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(432.0),
                               alignment: .leading)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(432.0),
                           alignment: .leading)
                    VStack {
                        Text(StringConstants.kLblExploreTheApp)
                            .font(FontScheme.kOutfitMedium(size: getRelativeHeight(20.0)))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(141.0), height: getRelativeHeight(26.0),
                                   alignment: .topLeading)
                            .padding(.horizontal, getRelativeWidth(37.0))
                        Text(StringConstants.kMsgLoremIpsumDol)
                            .font(FontScheme.kOutfitRegular(size: getRelativeHeight(30.0)))
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .frame(width: getRelativeWidth(327.0), height: getRelativeHeight(77.0), alignment: .center)
                            .padding(.top, getRelativeHeight(9.0))
                            .padding(.leading, getRelativeWidth(37.0))
                            .padding(.trailing, getRelativeWidth(23.0))
                        Button(action: {
                            exploreViewModel.nextScreen = "SignUpView"
                        }, label: {
                            HStack(spacing: 0) {
                                Text(StringConstants.kLblLetsStart)
                                    .font(FontScheme.kOutfitMedium(size: getRelativeHeight(20.0)))
                                    .fontWeight(.medium)
                                    .padding(.horizontal, getRelativeWidth(30.0))
                                    .padding(.vertical, getRelativeHeight(11.0))
                                    .foregroundColor(.black)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                                    .background(RoundedCorners(topLeft: 8.0, topRight: 8.0,
                                                               bottomLeft: 8.0, bottomRight: 8.0)
                                        .fill(Color(red: 1, green: 0.776, blue: 0)))
                            }
                        })
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                               alignment: .center)
                        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                   bottomRight: 8.0)
                            .fill(Color(red: 1, green: 0.776, blue: 0)))
                        .padding(.top, getRelativeHeight(49.0))
                        .padding(.leading, getRelativeWidth(37.0))
                        .padding(.trailing, getRelativeWidth(25.0))
                        Button(action: {
                            exploreViewModel.nextScreen = "LoginView"
                        }, label: {
                            HStack(spacing: 0) {
                                Text(StringConstants.kLblLogin)
                                    .font(FontScheme.kOutfitMedium(size: getRelativeHeight(20.0)))
                                    .fontWeight(.medium)
                                    .padding(.horizontal, getRelativeWidth(30.0))
                                    .padding(.vertical, getRelativeHeight(11.0))
                                    .foregroundColor(.black)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                                    .background(RoundedCorners(topLeft: 8.0, topRight: 8.0,
                                                               bottomLeft: 8.0, bottomRight: 8.0)
                                        .fill(Color(red: 1, green: 0.776, blue: 0)))
                                
                                
                            }
                        })
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                               alignment: .topLeading)
                        
                        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                   bottomRight: 8.0)
                            .fill(Color(red: 1, green: 0.776, blue: 0)))
                        .padding(.top, getRelativeHeight(12.0))
                        .padding(.leading, getRelativeWidth(37.0))
                        .padding(.trailing, getRelativeWidth(25.0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(270.0),
                           alignment: .leading)
                    .padding(.vertical, getRelativeHeight(55.0))
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .background(Color.white)
                .padding(.top, getRelativeHeight(30.0))
                .padding(.bottom, getRelativeHeight(10.0))
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                        self.checkInternetConnection()
                    }
                }
                
                .alert(isPresented: $showAlert) {
                    SwiftUI.Alert(
                        title: Text("Estado de la conexión"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                            showAlert = false
                        }
                    )
                }
                
                Group {
                    NavigationLink(destination: SignUpView(),
                                   tag: "SignUpView",
                                   selection: $exploreViewModel.nextScreen,
                                   label: {
                        EmptyView()
                    })
                }
                Group {
                    NavigationLink(destination: LoginView(),
                                   tag: "LoginView",
                                   selection: $exploreViewModel.nextScreen,
                                   label: {
                        EmptyView()
                    })
                }
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.white)
            .ignoresSafeArea()
            .hideNavigationBar()
            .onAppear {}
            .gesture(DragGesture().onChanged { _ in })
            
        }
    }
    func checkInternetConnection() {
        // Verifica la conexión a Internet utilizando networkManager
        let isConnected = networkManager.hasInternetConnection
        if isConnected {
            showAlert = false
        } else {
            // No hay conexión a Internet, muestra un mensaje de error solo si no se muestra actualmente.
            if !showAlert {
                alertMessage = "No hay conexión a Internet"
                showAlert = true
            }
        }
    }
}
struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


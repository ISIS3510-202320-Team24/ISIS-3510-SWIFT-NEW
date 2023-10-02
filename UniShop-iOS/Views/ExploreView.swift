import SwiftUI

struct ExploreView: View {
    @StateObject var exploreViewModel = ExploreViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                            .foregroundColor(ColorConstants.Black900)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(141.0), height: getRelativeHeight(26.0),
                                   alignment: .topLeading)
                            .padding(.horizontal, getRelativeWidth(37.0))
                        Text(StringConstants.kMsgLoremIpsumDol)
                            .font(FontScheme.kOutfitRegular(size: getRelativeHeight(12.0)))
                            .fontWeight(.regular)
                            .foregroundColor(ColorConstants.Black900)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .frame(width: getRelativeWidth(327.0), height: getRelativeHeight(77.0),
                                   alignment: .center)
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
                                    .foregroundColor(ColorConstants.Black900)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                                    .background(RoundedCorners(topLeft: 8.0, topRight: 8.0,
                                                               bottomLeft: 8.0, bottomRight: 8.0)
                                        .fill(ColorConstants.AmberA400))
                                  
                            }
                        })
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                               alignment: .center)
                        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                   bottomRight: 8.0)
                            .fill(ColorConstants.AmberA400))
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
                                    .foregroundColor(ColorConstants.Black900)
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .frame(width: getRelativeWidth(328.0),
                                           height: getRelativeHeight(48.0), alignment: .center)
                                    .background(RoundedCorners(topLeft: 8.0, topRight: 8.0,
                                                               bottomLeft: 8.0, bottomRight: 8.0)
                                        .fill(ColorConstants.AmberA400))
                                
                                  
                            }
                        })
                        .frame(width: getRelativeWidth(328.0), height: getRelativeHeight(48.0),
                               alignment: .topLeading)
                        
                        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                                   bottomRight: 8.0)
                            .fill(ColorConstants.AmberA400))
                        .padding(.top, getRelativeHeight(12.0))
                        .padding(.leading, getRelativeWidth(37.0))
                        .padding(.trailing, getRelativeWidth(25.0))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(270.0),
                           alignment: .leading)
                    .padding(.vertical, getRelativeHeight(55.0))
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .background(ColorConstants.WhiteA700)
                .padding(.top, getRelativeHeight(30.0))
                .padding(.bottom, getRelativeHeight(10.0))
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
            .background(ColorConstants.WhiteA700)
            .ignoresSafeArea()
            .hideNavigationBar()
            .onAppear {}
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


import SwiftUI

struct NavbarView: View {
    
    var buttonTappedHandler: ((Int) -> Void)?
    @State var activeTab = 0
    let labels = ["Home", "Posts", "Create", "Favorites", "Profile"]
    
    var body: some View {
        ZStack {
            VStack {    
                HStack(spacing: 0) {
                    ForEach(Array(labels.enumerated()), id: \.offset) { index, label in
                        Button(action: {
                            activeTab = index
                            buttonTappedHandler?(index)
                        }) {
                            if label != "Create" {
                                VStack {
                                    Spacer()
                                    Image(uiImage: (UIImage(named: iconName(for: label)) ?? UIImage()).withRenderingMode(.alwaysTemplate))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(index == activeTab ? Color(red: 1, green: 0.776, blue: 0) : Color(red: 0.30, green: 0.30, blue: 0.30))
                                    
                                    Text(label)
                                        .font(.system(size: 16))
                                        .foregroundColor(Color(red: 0.296, green: 0.335, blue: 0.402))
                                }
                                .padding(.bottom, 15)
                                .frame(width: UIScreen.main.bounds.width / CGFloat(labels.count), height: 86)
                            } else {
                                createButton
                                    .frame(width: UIScreen.main.bounds.width / CGFloat(labels.count), height: 86)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .border(Color(red: 0.896, green: 0.896, blue: 0.896), width: 1)
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var createButton: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(activeTab == 2 ? Color(red: 1, green: 0.776, blue: 0) : Color(red: 0.30, green: 0.30, blue: 0.30))
                    .frame(width: 50, height: 50)
                Image(uiImage: (UIImage(named: iconName(for: "Create")) ?? UIImage()).withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundColor(.white)
            }
            .offset(y: -13)
            
            Text("Create")
                .font(.system(size: 16))
                .foregroundColor(Color(red: 0.296, green: 0.335, blue: 0.402))
        }
        .padding(.bottom, 19)
    }
    
    func iconName(for label: String) -> String {
        return label.lowercased().replacingOccurrences(of: " ", with: "")
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}

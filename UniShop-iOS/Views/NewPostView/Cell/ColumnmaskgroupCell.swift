import SwiftUI

struct ColumnmaskgroupCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("img_maskgroup")
                    .resizable()
                    .frame(width: getRelativeWidth(60.0), height: getRelativeWidth(62.0),
                           alignment: .leading)
                    .scaledToFit()
                Text(StringConstants.kLblMellisaCarter)
                    .font(FontScheme.kArchivoRomanRegular(size: getRelativeHeight(14.0)))
                    .fontWeight(.regular)
                    .foregroundColor(ColorConstants.Gray901)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                    .frame(width: getRelativeWidth(84.0), height: getRelativeHeight(15.0),
                           alignment: .leading)
                    .padding(.vertical, getRelativeHeight(23.0))
                    .padding(.leading, getRelativeWidth(16.0))
            }
            .frame(width: getRelativeWidth(162.0), height: getRelativeHeight(62.0),
                   alignment: .leading)
            .padding(.leading, getRelativeWidth(7.0))
            .padding(.trailing, getRelativeWidth(7.0))
            ZStack {
                Image("img_unsplash8atje")
                    .resizable()
                    .frame(width: getRelativeWidth(333.0), height: getRelativeHeight(353.0),
                           alignment: .leading)
                    .scaledToFit()
                    .background(RoundedCorners(topLeft: 7.07, topRight: 7.07, bottomLeft: 7.07,
                                               bottomRight: 7.07))
            }
            .hideNavigationBar()
            .frame(width: getRelativeWidth(333.0), height: getRelativeHeight(353.0),
                   alignment: .leading)
            .background(RoundedCorners(topLeft: 7.07, topRight: 7.07, bottomLeft: 7.07,
                                       bottomRight: 7.07)
                    .fill(ColorConstants.WhiteA700))
            .padding(.top, getRelativeHeight(7.0))
            .padding(.horizontal, getRelativeWidth(7.0))
            HStack {
                HStack {
                    Image("img_vector")
                        .resizable()
                        .frame(width: getRelativeWidth(17.0), height: getRelativeHeight(17.0),
                               alignment: .leading)
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 0) {
                        Text(StringConstants.kLblIgnition)
                            .font(FontScheme.kArchivoRomanMedium(size: getRelativeHeight(16.0)))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(52.0), height: getRelativeHeight(17.0),
                                   alignment: .leading)
                        Text(StringConstants.kLblOil)
                            .font(FontScheme.kArchivoRomanRegular(size: getRelativeHeight(12.0)))
                            .fontWeight(.regular)
                            .foregroundColor(ColorConstants.Bluegray400)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(width: getRelativeWidth(13.0), height: getRelativeHeight(13.0),
                                   alignment: .leading)
                            .padding(.trailing, getRelativeWidth(10.0))
                    }
                    .frame(width: getRelativeWidth(52.0), height: getRelativeHeight(32.0),
                           alignment: .leading)
                    .padding(.leading, getRelativeWidth(19.0))
                }
                .frame(width: getRelativeWidth(91.0), height: getRelativeHeight(32.0),
                       alignment: .leading)
                .padding(.vertical, getRelativeHeight(14.0))
                Spacer()
                Button(action: {}, label: {
                    HStack(spacing: 0) {
                        Text(StringConstants.kLblLearnMore)
                            .font(FontScheme.kArchivoRomanRegular(size: getRelativeHeight(14.0)))
                            .fontWeight(.regular)
                            .padding(.horizontal, getRelativeWidth(30.0))
                            .padding(.vertical, getRelativeHeight(16.0))
                            .foregroundColor(ColorConstants.WhiteA700)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .frame(width: getRelativeWidth(133.0), height: getRelativeHeight(47.0),
                                   alignment: .center)
                            .background(RoundedCorners(topLeft: 6.0, topRight: 6.0, bottomLeft: 6.0,
                                                       bottomRight: 6.0)
                                    .fill(ColorConstants.Indigo600))
                    }
                })
                .frame(width: getRelativeWidth(133.0), height: getRelativeHeight(47.0),
                       alignment: .center)
                .background(RoundedCorners(topLeft: 6.0, topRight: 6.0, bottomLeft: 6.0,
                                           bottomRight: 6.0)
                        .fill(ColorConstants.Indigo600))
            }
            .frame(width: getRelativeWidth(322.0), height: getRelativeHeight(47.0),
                   alignment: .leading)
            .padding(.vertical, getRelativeHeight(11.0))
            .padding(.leading, getRelativeWidth(18.0))
            .padding(.trailing, getRelativeWidth(8.0))
        }
        .frame(width: getRelativeWidth(348.0), alignment: .leading)
        .overlay(RoundedCorners(topLeft: 7.07, topRight: 7.07, bottomLeft: 7.07, bottomRight: 7.07)
            .stroke(ColorConstants.Gray90014,
                    lineWidth: 1))
        .background(RoundedCorners(topLeft: 7.07, topRight: 7.07, bottomLeft: 7.07,
                                   bottomRight: 7.07)
                .fill(Color.clear.opacity(0.7)))
        .shadow(color: ColorConstants.Gray90026, radius: 104, x: 0, y: 28)
        .hideNavigationBar()
    }
}

/* struct ColumnmaskgroupCell_Previews: PreviewProvider {

 static var previews: some View {
 			ColumnmaskgroupCell()
 }
 } */

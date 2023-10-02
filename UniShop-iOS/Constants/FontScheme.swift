import Foundation
import SwiftUI

class FontScheme: NSObject {
    static func kOutfitMedium(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kOutfitMedium, size: size)
    }

    static func kOutfitRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kOutfitRegular, size: size)
    }

    static func kOutfitSemiBold(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kOutfitSemiBold, size: size)
    }

    static func kOutfitBold(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kOutfitBold, size: size)
    }

    static func kPoppinsRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kPoppinsRegular, size: size)
    }

    static func kArchivoRomanMedium(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kArchivoRomanMedium, size: size)
    }

    static func kArchivoRomanRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kArchivoRomanRegular, size: size)
    }

    static func fontFromConstant(fontName: String, size: CGFloat) -> Font {
        var result = Font.system(size: size)

        switch fontName {
        case "kOutfitMedium":
            result = self.kOutfitMedium(size: size)
        case "kOutfitRegular":
            result = self.kOutfitRegular(size: size)
        case "kOutfitSemiBold":
            result = self.kOutfitSemiBold(size: size)
        case "kOutfitBold":
            result = self.kOutfitBold(size: size)
        case "kPoppinsRegular":
            result = self.kPoppinsRegular(size: size)
        case "kArchivoRomanMedium":
            result = self.kArchivoRomanMedium(size: size)
        case "kArchivoRomanRegular":
            result = self.kArchivoRomanRegular(size: size)
        default:
            result = self.kOutfitMedium(size: size)
        }
        return result
    }

    enum FontConstant {
        /**
         * Please Add this fonts Manually
         */
        static let kOutfitMedium: String = "Outfit-Medium"
        /**
         * Please Add this fonts Manually
         */
        static let kOutfitRegular: String = "Outfit-Regular"
        /**
         * Please Add this fonts Manually
         */
        static let kOutfitSemiBold: String = "Outfit-SemiBold"
        /**
         * Please Add this fonts Manually
         */
        static let kOutfitBold: String = "Outfit-Bold"
        /**
         * Please Add this fonts Manually
         */
        static let kPoppinsRegular: String = "Poppins-Regular"
        /**
         * Please Add this fonts Manually
         */
        static let kArchivoRomanMedium: String = "ArchivoRoman-Medium"
        /**
         * Please Add this fonts Manually
         */
        static let kArchivoRomanRegular: String = "ArchivoRoman-Regular"
    }
}

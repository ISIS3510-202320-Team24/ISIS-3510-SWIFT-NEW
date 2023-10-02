import Foundation
import SwiftUI

class NewPostViewModel: ObservableObject {
    @Published var isAlertShow = false
    @Published var alertTitle = ""
    @Published var alertDescription = ""
    @Published var descriptionText: String = ""
    @Published var descripptioonText: String = ""
    @Published var isActionSheetShow: Bool = false
    @Published var isImagePickerShow: Bool = false
    @Published var selectedImage: UIImage = .init()
    @Published var imagePickerSource = UIImagePickerController.SourceType.photoLibrary
    @Published var iaccepttheprCheckbox: Bool = false

    func showAlert(_ title: String, _ message: String) {
        self.isAlertShow = true
        self.alertTitle = title
        self.alertDescription = message
    }
}

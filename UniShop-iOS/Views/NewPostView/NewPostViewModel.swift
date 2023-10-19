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
    func allFieldsValid (name:String,description:String,price:String,subject:String,degree:String) -> Bool{
    
        return !name.isEmpty && !description.isEmpty && !price.isEmpty && !subject.isEmpty && !degree.isEmpty
    }


}

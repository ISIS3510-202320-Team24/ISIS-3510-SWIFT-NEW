//
//  ImagePicker.swift
//

import SwiftUI
import UIKit

struct MediaPicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var mediaTypes: [String] = ["public.image"]

    var imagePicked: ((_ image: UIImage?, _ video: URL?) -> Void)?

    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<MediaPicker>)
        -> UIImagePickerController
    {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = mediaTypes
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_: UIImagePickerController,
                                context _: UIViewControllerRepresentableContext<MediaPicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate,
        UINavigationControllerDelegate
    {
        var parent: MediaPicker

        init(_ parent: MediaPicker) {
            self.parent = parent
        }

        func imagePickerController(_: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController
                                       .InfoKey: Any])
        {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if let imagePicked = parent.imagePicked {
                    imagePicked(image, nil)
                }
            }

            if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                if let imagePicked = parent.imagePicked {
                    imagePicked(nil, videoURL)
                }
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

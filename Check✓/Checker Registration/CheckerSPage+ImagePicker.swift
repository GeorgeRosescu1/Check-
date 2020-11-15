//
//  CheckerSP+ImagePicker.swift
//  Check✓
//
//  Created by George Rosescu on 12/11/2020.
//

import Foundation
import UIKit

extension CheckerSecondPageRegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleImagePicking() {
        let imageAlert = UIAlertController(title: "Profile picture", message: "Choose a profile picture from Photo library or take one using the Camera.", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Photo library", style: .default) { _ in
            let libraryPicker = UIImagePickerController()
            libraryPicker.sourceType = .photoLibrary
            libraryPicker.allowsEditing = true
            libraryPicker.delegate = self
            self.present(libraryPicker, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = .camera
            cameraPicker.allowsEditing = true
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        imageAlert.addAction(libraryAction)
        imageAlert.addAction(cameraAction)
        imageAlert.addAction(cancelAction)
        
        present(imageAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        profilePicture.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
}

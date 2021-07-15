//
//  DeviceInfoViewController.swift
//  Collections
//
//  Created by admin on 14.07.2021.
//

import UIKit

class DeviceInfoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    @IBOutlet weak var deviceInfoView: UIView!
    @IBOutlet private weak var deviceImageView: UIImageView!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var modelTextField: UITextField!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var infoTextView: UITextView!
    
    
    var device: Device?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Device info"
        let rightButtonItem = UIBarButtonItem.init(title: UserMessagesAndTitles.editTitle, style: .plain, target: self, action: #selector (editButtonAction))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        deviceInfoView.layer.cornerRadius = 8
        deviceInfoView.layer.masksToBounds = true
        setUpDetailInfo()
        
    }
    @objc func editButtonAction() {
        let actionSheet = UIAlertController(title: UserMessagesAndTitles.alertTitle,
                                            message:"",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.changePhotoTitle,
                                            style: .default,
                                            handler:{ (action) in
                                                self.showImagePickerController(sourceType: .photoLibrary)} ))
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.cancelTitle,
                                            style: .cancel,
                                            handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setUpDetailInfo () {
        guard let device = device else { return }
        guard let unwrapedPpi = device.ppi else {return}
        let ppi = String(unwrapedPpi)
        let diagonal = String(device.diagonal)
        
        modelTextField.text = device.description
        infoTextView.text = "PPI: \(ppi), Diagonal: \(diagonal) inch."
        deviceImageView.image = UIImage(named: device.imageName)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            deviceImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            deviceImageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}


//
//  DeviceInfoViewController.swift
//  Collections
//
//  Created by admin on 14.07.2021.
//

import UIKit

class DeviceInfoViewController: UIViewController,  UINavigationControllerDelegate {
    
    @IBOutlet private weak var deviceInfoStackView: UIStackView!
    @IBOutlet private weak var deviceInfoView: UIView!
    @IBOutlet private weak var deviceImageView: UIImageView!
    @IBOutlet private weak var modelLabel: UILabel!
    @IBOutlet private weak var modelTextField: UITextField!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var infoTextView: UITextView!
    
    var device: LocalDevices?
    
    var deviceType: DeviceType = .iPhone
    
    var saveClosure: (( _ device: LocalDevices) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelTextField.delegate = self
        infoTextView.delegate = self
        
        setUpViewController()
        setUpDetailInfo()
        setButtons()
    }
}
extension DeviceInfoViewController {
    
    private func setUpViewController() {
        
        self.navigationItem.title = UserMessagesAndTitles.deviceInfoTitle
        
        deviceInfoView.layer.cornerRadius = 8
        deviceInfoView.layer.masksToBounds = true
        deviceInfoView.layer.borderWidth = 0.8
        deviceInfoView.layer.borderColor = UIColor.darkGray.cgColor
        infoTextView.layer.cornerRadius = 8
        infoTextView.layer.masksToBounds = true
        infoTextView.layer.borderWidth = 0.6
        infoTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUpDetailInfo () {
        modelTextField.text = device?.title
        infoTextView.text = device?.info
        deviceImageView.image = device?.image ?? UIImage(named: "Unknown")
    }
    
    private func setButtons() {
        let saveButtonItem = UIBarButtonItem.init(title: UserMessagesAndTitles.saveTitle,
                                                  style: .plain, target: self,
                                                  action: #selector(saveButtonAction))
        
        let editButtonItem = UIBarButtonItem.init(title: UserMessagesAndTitles.editTitle,
                                                  style: .plain, target: self,
                                                  action: #selector (editButtonAction))
        let rightButtons = [saveButtonItem, editButtonItem]
        
        self.navigationItem.rightBarButtonItems = rightButtons
    }
    
    @objc func editButtonAction() {
        let actionSheet = UIAlertController(title: UserMessagesAndTitles.alertTitle,
                                            message:"",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.changePhotoTitle,
                                            style: .default,
                                            handler:{ (action) in
                                                self.showImagePickerController(sourceType: .photoLibrary)}))
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.chooseCameraTitle,
                                            style: .default,
                                            handler:{ (action) in
                                                if UIImagePickerController.isSourceTypeAvailable(.camera){
                                                    self.showImagePickerController(sourceType: .camera) }
                                                else {
                                                    let alertController = UIAlertController(title: nil,
                                                                                            message: UserMessagesAndTitles.deviceHasNoCameraTitle,
                                                                                            preferredStyle: .alert)
                                                    
                                                    let okAction = UIAlertAction(title: UserMessagesAndTitles.alrightTitle,
                                                                                 style: .default, handler: nil)
                                                    
                                                    alertController.addAction(okAction)
                                                    self.present(alertController, animated: true, completion: nil)
                                                }
                                            }))
        actionSheet.addAction(UIAlertAction(title: UserMessagesAndTitles.cancelTitle,
                                            style: .cancel,
                                            handler:nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func saveButtonAction () {
        
        guard let device = device else {
            let newDevice = LocalDevices(title: self.modelTextField.text ?? "",
                                         info: self.infoTextView.text ?? "",
                                         image: self.deviceImageView.image ?? UIImage(named: "Unknown")!,
                                         type: self.deviceType)
            
            self.saveClosure?(newDevice)
            self.navigationController?.popViewController(animated: true)
            return
        }
        device.image = deviceImageView.image ?? UIImage(named: "Unknown")!
        device.title = modelTextField.text ?? ""
        device.info = infoTextView.text ?? ""
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
 
extension DeviceInfoViewController : UIImagePickerControllerDelegate {
    
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

extension DeviceInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modelTextField.resignFirstResponder()
        return true
    }
}
    
extension DeviceInfoViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.infoTextView.resignFirstResponder()
            return false
        }
        return true
    }
}
    
    

//
//  AppleDeviceTableViewCell.swift
//  Collections
//
//  Created by admin on 13.07.2021.
//

import UIKit

class AppleDeviceTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var deviceImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ppiDiagonalLable: UILabel!
    
    static let identifier = "AppleDeviceTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AppleDeviceTableViewCell", bundle: nil)
    }
   
    func configure (device: LocalDevices) {
        descriptionLabel.text = device.title
        ppiDiagonalLable.text = device.info
        deviceImageView.image = device.image
    }
}

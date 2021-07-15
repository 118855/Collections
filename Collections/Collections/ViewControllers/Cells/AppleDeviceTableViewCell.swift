//
//  AppleDeviceTableViewCell.swift
//  Collections
//
//  Created by admin on 13.07.2021.
//

import UIKit

class AppleDeviceTableViewCell: UITableViewCell {
    
    @IBOutlet  private weak var deviceImageView: UIImageView!
    @IBOutlet  private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ppiDiagonalLable: UILabel!
    
    static let identifier = "AppleDeviceTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AppleDeviceTableViewCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure (device: Device) {
        guard let unwrapedPpi = device.ppi else {return}
        let ppi = String(unwrapedPpi)
        let diagonal = String(device.diagonal)
        
        descriptionLabel.text = device.description
        ppiDiagonalLable.text = "PPI: \(ppi), Diagonal: \(diagonal) inch."
        deviceImageView.image = UIImage(named: device.imageName)
    }
}

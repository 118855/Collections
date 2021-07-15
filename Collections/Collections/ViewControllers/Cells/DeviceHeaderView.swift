//
//  DeviceHeaderView.swift
//  Collections
//
//  Created by admin on 15.07.2021.
//

import UIKit

protocol HeaderViewDelegate: class {
    func expandedSection(button: UIButton)
}

final class DeviceHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: HeaderViewDelegate?
    
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var headerButtom: UIButton!
    
    static let identifier = "DeviceHeaderView"
    
    static func nib() -> UINib {
        return UINib(nibName: "DeviceHeaderView", bundle: nil)
    }
    
    @IBAction func didTapHeader(_ sender: UIButton) {
        delegate?.expandedSection(button: sender)
    }
    
    func configure(title: String, section: Int) {
        deviceLabel.text = title
        headerButtom.tag = section
    }
}

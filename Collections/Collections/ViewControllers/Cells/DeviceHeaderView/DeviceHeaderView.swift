//
//  DeviceHeaderView.swift
//  Collections
//
//  Created by admin on 15.07.2021.
//

import UIKit

protocol DeviceHeaderViewDelegate: class {
    func deviceHeaderViewExpandedSection(_ deviceHeaderView: DeviceHeaderView, type: DeviceType)
    func deviceHeaderViewAddNewDevice(_ deviceHeaderView: DeviceHeaderView, type: DeviceType)
}

final class DeviceHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: DeviceHeaderViewDelegate?
    
    private var deviceType: DeviceType = .iPhone
    
    static let identifier = "DeviceHeaderView"
    
    static func nib() -> UINib { return UINib(nibName: "DeviceHeaderView", bundle: nil)}
    
    @IBOutlet private weak var deviceLabel: UILabel!
    @IBOutlet private weak var headerButtom: UIButton!
    @IBOutlet private weak var addButtonLabel: UIButton!
    
    override func draw(_ rect: CGRect) {
        setupHeaderView()
    }
    
    
    @IBAction func didTapHeader(_ sender: UIButton) {
        delegate?.deviceHeaderViewExpandedSection(self, type: deviceType)
    }
    
    
    @IBAction func didTapAddButton(_ sender: UIButton) {
        delegate?.deviceHeaderViewAddNewDevice(self, type: deviceType)
    }
    
    func configure(title: String, type: DeviceType) {
        deviceLabel.text = title
        self.deviceType = type
    }
    
    private func setupHeaderView () {
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = UIColor(white: 0.5, alpha: 1)
        self.backgroundView?.layer.cornerRadius = 10
        self.backgroundView?.layer.masksToBounds = true
        self.backgroundView?.layer.borderWidth = 0.8
        self.backgroundView?.layer.borderColor = UIColor.darkGray.cgColor
    }
}

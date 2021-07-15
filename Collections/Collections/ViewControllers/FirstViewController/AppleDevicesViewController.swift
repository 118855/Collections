//
//  ViewController.swift
//  Collections
//
//  Created by admin on 12.07.2021.
//

import UIKit
protocol AppleDevicesViewControllerDelegate: class {
    func appleDeviceViewController(_ viewController: UIViewController, didUpdate cell: String)
}

class AppleDevicesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let heightForRow: CGFloat = 60
    var allDevices = Device.allPads + Device.allPhones
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.register(AppleDeviceTableViewCell.nib(), forCellReuseIdentifier: AppleDeviceTableViewCell.identifier)
    }
}

extension AppleDevicesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppleDeviceTableViewCell.identifier)
                as? AppleDeviceTableViewCell else {return UITableViewCell()}
        
        let device = allDevices[indexPath.row]
        cell.configure(device: device)
        return cell
    }
}

extension AppleDevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = allDevices[indexPath.row]
        let viewController = DeviceInfoViewController(nibName: DeviceInfoViewController.identifier, bundle: nil)
        viewController.device = device
        navigationController?.pushViewController(viewController, animated: true)
    }
}





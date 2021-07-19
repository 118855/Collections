//
//  AppleDevicesViewController.swift
//  Collections
//
//  Created by admin on 12.07.2021.
//

import UIKit

class AppleDevicesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let heightForRow: CGFloat = 60
    private var allDevices: [LocalDevices] = NewDeviceModel.newDevice.allDevices
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AppleDeviceTableViewCell.nib(), forCellReuseIdentifier: AppleDeviceTableViewCell.identifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.allDevices = NewDeviceModel.newDevice.allDevices
        
        tableView.reloadData()
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
        tableView.deselectRow(at: indexPath, animated: true)
        let device = allDevices[indexPath.row]
        let viewController = DeviceInfoViewController(nibName: DeviceInfoViewController.identifier, bundle: nil)
        
        viewController.device = device
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.allDevices.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        default :
            break
        }
    }
}





//
//  TwoSectionsViewController.swift
//  Collections
//
//  Created by admin on 13.07.2021.
//

import UIKit

class TwoSectionsViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private let heightForHeaderInSection: CGFloat = 50
    private let heightForRow: CGFloat = 60
    
    private var arrayOfData: [ExpandedSections] =
        [ExpandedSections(isExpanded: false,
                          title: UserMessagesAndTitles.iPadTitle,
                          deviceArray: NewDeviceModel.newDevice.getDevices(by: .iPad)),
         ExpandedSections(isExpanded: false,
                          title: UserMessagesAndTitles.iPhoneTitle,
                          deviceArray: NewDeviceModel.newDevice.getDevices(by: .iPhone))
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AppleDeviceTableViewCell.nib(), forCellReuseIdentifier: AppleDeviceTableViewCell.identifier)
        
        tableView.register(DeviceHeaderView.nib(), forHeaderFooterViewReuseIdentifier: DeviceHeaderView.identifier)
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
}

extension TwoSectionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfData[section].isExpanded ? arrayOfData[section].deviceArray.count : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DeviceHeaderView.identifier)
            as? DeviceHeaderView
        
        headerView?.configure(title: arrayOfData[section].title, type: DeviceType(rawValue: section)!)
        headerView?.delegate = self
        
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppleDeviceTableViewCell.identifier,for: indexPath)
                as? AppleDeviceTableViewCell else { return UITableViewCell() }
        
        let device = arrayOfData[indexPath.section].deviceArray[indexPath.row]
        
        cell.configure(device: device)
        
        return cell
    }
}

extension TwoSectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let device = arrayOfData[indexPath.section].deviceArray[indexPath.row]
        let viewController = DeviceInfoViewController(nibName: DeviceInfoViewController.identifier,
                                                      bundle: nil)
        viewController.device = device
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let device = self.arrayOfData[indexPath.section].deviceArray[indexPath.row]
            NewDeviceModel.newDevice.removeDevice(removeDevice: device)
            
            arrayOfData[indexPath.section].deviceArray.remove(at: indexPath.row)
            if arrayOfData[indexPath.section].deviceArray.count > 0 {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                self.arrayOfData.remove(at: indexPath.section)
                self.tableView.deleteSections([indexPath.section], with: .automatic)
            }
        default:
            break
        }
    }
}

extension TwoSectionsViewController: DeviceHeaderViewDelegate {
    
    func deviceHeaderViewAddNewDevice(_ deviceHeaderView: DeviceHeaderView, type: DeviceType) {
        let viewController = DeviceInfoViewController(nibName: DeviceInfoViewController.identifier,
                                                      bundle: nil)
        
        viewController.deviceType = type
        
        viewController.saveClosure = {(_ device: LocalDevices) -> () in
            NewDeviceModel.newDevice.allDevices.append(device)
            
            self.reloadDevicesForType(deviceType: type)
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func reloadDevicesForType(deviceType: DeviceType) {
        arrayOfData[deviceType.rawValue].deviceArray = NewDeviceModel.newDevice.getDevices(by: deviceType)
        
        tableView.reloadSections(IndexSet(integer: deviceType.rawValue), with: .automatic)
    }
    
    func deviceHeaderViewExpandedSection(_ deviceHeaderView: DeviceHeaderView, type: DeviceType) {
        let isExpanded = arrayOfData[type.rawValue].isExpanded
        arrayOfData[type.rawValue].isExpanded = !isExpanded
        
        tableView.reloadSections(IndexSet(integer: type.rawValue), with: .automatic)
    }
}

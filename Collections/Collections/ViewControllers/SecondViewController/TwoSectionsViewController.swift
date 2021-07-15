//
//  TwoSectionsViewController.swift
//  Collections
//
//  Created by admin on 13.07.2021.
//

import UIKit

class TwoSectionsViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    var arrayOfData: [ExpandedSections] =
        [ExpandedSections(isExpanded: false,
                          title: UserMessagesAndTitles.iPhoneTitle,
                          array: Device.allPhones),
         ExpandedSections(isExpanded: false, title: UserMessagesAndTitles.iPadTitle, array: Device.allPads)
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AppleDeviceTableViewCell.nib(), forCellReuseIdentifier: AppleDeviceTableViewCell.identifier)
        tableView.register(DeviceHeaderView.nib(), forHeaderFooterViewReuseIdentifier: DeviceHeaderView.identifier)
        tableView.tableFooterView = UIView()
    }
    
}

extension TwoSectionsViewController: UITableViewDataSource, HeaderViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData[section].isExpanded ? arrayOfData[section].array.count : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DeviceHeaderView.identifier)
            as? DeviceHeaderView
        headerView?.configure(title: arrayOfData[section].title, section: section)
        headerView?.delegate = self
        headerView?.layer.cornerRadius = 10
        headerView?.layer.masksToBounds = true
        headerView?.layer.borderWidth = 0.8
        headerView?.layer.borderColor = UIColor.black.cgColor
        
        let addButton: UIButton = UIButton(frame: CGRect(x: 350, y: 5, width: 45, height: 35))
        addButton.setTitleColor(.link, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(TwoSectionsViewController.didPressAddButton(_:)),
                            for: .touchUpInside)
        
        headerView?.addSubview(addButton)
        return headerView
    }
    
    @objc func didPressAddButton (_ sender: UIButton!) {
        let viewController = DeviceInfoViewController(nibName: DeviceInfoViewController.identifier,
                                                      bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppleDeviceTableViewCell.identifier,
                                                       for: indexPath) as? AppleDeviceTableViewCell else {return UITableViewCell()}
        let device = arrayOfData[indexPath.section].array[indexPath.row]
        cell.configure(device: device)
        return cell
    }
    
    func expandedSection(button: UIButton) {
        let section = button.tag
        let isExpanded = arrayOfData[section].isExpanded
        arrayOfData[section].isExpanded = !isExpanded
        
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

extension TwoSectionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = arrayOfData[indexPath.section].array[indexPath.row]
        let viewController = DeviceInfoViewController(nibName: DeviceInfoViewController.identifier,
                                                      bundle: nil)
        viewController.device = device
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayOfData[indexPath.section].array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}




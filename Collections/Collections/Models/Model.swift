//
//  Model.swift
//  Collections
//
//  Created by admin on 14.07.2021.
//

import Foundation
import UIKit

class LocalDevices {
    var title: String
    var image: UIImage
    var info: String
    var type: DeviceType
    
    init(title: String, info: String, image: UIImage, type: DeviceType) {
        self.title = title
        self.info = info
        self.image = image
        self.type = type
    }
    
    static func getAllPads() -> [LocalDevices] {
        let allPads = Device.allPads.map { device -> LocalDevices in
            let iPads = LocalDevices(title: device.description,
                                     info: "PPI: \(String(device.ppi ?? 0)), Diagonal: \(String(device.diagonal)) inch.",
                                     image: UIImage(named: device.imageName) ?? UIImage(),
                                     type: .iPad)
            return iPads
        }
        return allPads
    }
    
    static func getAllPhones () -> [LocalDevices] {
        let allPhones = Device.allPhones.map { device -> LocalDevices in
            let iPhones = LocalDevices(title: device.description,
                                       info: "PPI: \(String(device.ppi ?? 0)), Diagonal: \(String(device.diagonal)) inch.",
                                       image: UIImage(named: device.imageName) ?? UIImage(),
                                       type: .iPhone)
            return iPhones
        }
        return allPhones
    }
    
    static func getDevices(by type: DeviceType) -> [LocalDevices] {
        switch type {
        case .iPhone:
            return self.getAllPhones()
        case .iPad:
            return self.getAllPads()
        }
    }
    static func getAllDevices() -> [LocalDevices] {
        return getAllPhones() + getAllPads()
    }
}

enum DeviceType: Int {
    case iPhone = 0
    case iPad = 1
}

struct ExpandedSections {
    var isExpanded: Bool
    let title: String
    var deviceArray: [LocalDevices]
}

class NewDeviceModel {
    
    static let newDevice = NewDeviceModel()
    
    var allDevices = [LocalDevices]()
    
    init() {
        self.allDevices = LocalDevices.getAllDevices()
    }
    
    func removeDevice(removeDevice: LocalDevices) {
        let firstIndex = self.allDevices.firstIndex { (device) -> Bool in
            return removeDevice === device
        }
        guard let index = firstIndex else {return}
        self.allDevices.remove(at: index)
    }
    
    func getDevices(by type: DeviceType) -> [LocalDevices] {
        switch type {
        case .iPhone:
            return self.getPhones()
        case .iPad:
            return self.getPads()
        }
    }
    
    func getPhones() -> [LocalDevices] {
        let filteredPhones = self.allDevices.filter { (device) -> Bool in
            return device.type == .iPhone
        }
        return filteredPhones
    }
    
    func getPads() -> [LocalDevices] {
        let filteredPads = self.allDevices.filter { (device) -> Bool in
            return device.type == .iPad
        }
        return filteredPads
    }
}





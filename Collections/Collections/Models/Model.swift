//
//  Model.swift
//  Collections
//
//  Created by admin on 14.07.2021.
//

import Foundation

struct ExpandedSections {
    var isExpanded: Bool
    let title: String
    var array: [Device]
}

extension Device {
    public var imageName: String {
        switch self {
        case .iPhone4s: return "iphone4s"
        case .iPhone5: return "iphone5"
        case .iPhone5c: return "iphone5c"
        case .iPhone5s: return "iphone5s"
        case .iPhone6: return "iphone6"
        case .iPhone6Plus: return "iphone6plus"
        case .iPhone6s: return "iphone6s"
        case .iPhone6sPlus: return "iphone6splus"
        case .iPhone7: return "iphone7"
        case .iPhone7Plus: return "iphone7plus"
        case .iPhoneSE: return "iphoneSe"
        case .iPhone8: return "iphone8"
        case .iPhone8Plus: return "iphone8plus"
        case .iPhoneX: return "iphoneX"
        case .iPhoneXS: return "iphoneXs"
        case .iPhoneXSMax: return "iphoneXsmax"
        case .iPhoneXR: return "iphoneXr"
        case .iPad5: return "ipad5gen"
        case .iPad6: return "ipad6gen"
        case .iPadAir3: return "ipadAir3gen"
        case .iPadMini: return "ipadMini"
        case .iPadMini2: return "ipadMini2"
        case .iPadMini3: return "ipadMini3"
        case .iPadMini4: return "ipadMini4"
        case .iPadMini5: return "ipadMini5"
        case .iPadPro9Inch: return "ipadPro"
        case .iPadPro12Inch: return "ipadPro12.1gen"
        case .iPadPro12Inch2: return "ipadPro12.2gen"
        case .iPadPro10Inch: return "ipadPro10"
        case .iPadPro11Inch: return "ipadPro11"
        case .iPadPro12Inch3: return "ipadPro12.3gen"
        default : return "Unknown"
        }
    }
}


//
//  FontExtension.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/14/22.
//

import Foundation
import UIKit

extension UIFont{
    enum MontserratType: String{
        case light = "Montserrat-Light"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"
        case bold = "Montserrat-SemiBold"
    }
    
    static func montserratFont(withMontserrat fontType: MontserratType, withSize size: CGFloat)-> UIFont {
        return UIFont(name: fontType.rawValue, size: size)!
    }
}

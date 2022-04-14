//
//  UIColor+Extension.swift
//  Pokedex
//
//  Created by simon rebiere on 02/04/2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
          assert(red >= 0 && red <= 255, "Invalid red component")
          assert(green >= 0 && green <= 255, "Invalid green component")
          assert(blue >= 0 && blue <= 255, "Invalid blue component")

          self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
      }

      convenience init(rgb: Int) {
          self.init(
              red: (rgb >> 16) & 0xFF,
              green: (rgb >> 8) & 0xFF,
              blue: rgb & 0xFF
          )
      }
    
    open class var lightGrey: UIColor { return UIColor(rgb: 0xBCCAD6) }
    open class var darkGrey: UIColor { return UIColor(rgb: 0x30343F) }
    open class var shadowBlue: UIColor { return UIColor(rgb: 0x8D9DB6) }
    
}

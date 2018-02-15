//
//  iphonex.swift
//  EpubReaderKit
//
//  Created by Zhu Kui on 2018/01/17.
//

import UIKit

let is_iPhoneX: Bool = {
    guard #available(iOS 11.0, *),
        UIDevice().userInterfaceIdiom == .phone else {
            return false
    }
    let nativeSize = UIScreen.main.nativeBounds.size
    let (w, h) = (nativeSize.width, nativeSize.height)
    let (d1, d2): (CGFloat, CGFloat) = (1125.0, 2436.0)
    return (w == d1 && h == d2) || (w == d2 && h == d1)
}()

let iPhoneX_Portrait_Bottom_Height:CGFloat = 34
let iPhoneX_Portrait_Top_Height:CGFloat = 44
let iPhone_StatusBar_Height:CGFloat = 20


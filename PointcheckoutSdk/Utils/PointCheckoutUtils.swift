//
//  PointCheckoutUtils.swift
//  PointCheckoutSdk
//
//  Created by Abdullah Asendar on 6/24/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

import Foundation

class PointCheckoutUtils {
    static func isJailbroken() -> Bool {
        #if arch(i386) || arch(x86_64)
        // This is a Simulator not an idevice
        return false
        #else
        let fm = FileManager.default
        if(fm.fileExists(atPath: "/private/var/lib/apt")) {
            // This Device is jailbroken
            return true
        } else {
            // Continue the device is not jailbroken
            return false
        }
        #endif
    }
}



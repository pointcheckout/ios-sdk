//
//  PointCheckoutEnvironment.swift
//  PointcheckoutSdk
//
//  Created by Abdullah Asendar on 9/17/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

import Foundation

public enum PointCheckoutEnvironment {
    case PRODUCTION
    case TEST
    
    func getUrl() -> String {
        if self == PointCheckoutEnvironment.PRODUCTION {
            return "https://pay.pointcheckout.com"
        }
        
        return "https://pay.test.pointcheckout.com"
    }
}

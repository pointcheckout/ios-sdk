//
//  PointCheckoutEnvironment.swift
//  PointCheckoutSdk
//
//  Created by Abdullah Asendar on 9/17/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

import Foundation

public enum PointCheckoutEnvironment {
    case PRODUCTION
    case TEST
    case DEBUG
    
    func getUrl() -> String {
        if self == PointCheckoutEnvironment.PRODUCTION {
            return "https://pay.pointcheckout.com"
        }
        
        if self == PointCheckoutEnvironment.TEST {
            return "https://pay.test.pointcheckout.com"
        }
        
        return "https://pay.staging.pointcheckout.com"
    }
    
    static func getEnviornment(_ redirectUrl: String) -> PointCheckoutEnvironment?{
        
        let url = URL(string: redirectUrl);
        if (!(url?.host?.hasSuffix("pointcheckout.com") ?? false)){
            return nil;
        }
        
        if(url?.host == "pay.pointcheckout.com") {
            return PointCheckoutEnvironment.PRODUCTION;
        }
        
        if(url?.host == "pay.test.pointcheckout.com") {
            return PointCheckoutEnvironment.TEST;
        }
        
        return PointCheckoutEnvironment.DEBUG;
        
    }
}

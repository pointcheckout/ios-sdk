//
//  PointCheckoutClient.swift
//  PointCheckoutSdk
//
//  Created by Abdullah Asendar on 6/24/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

import UIKit

public class PointCheckoutClient {
    
    var environment: PointCheckoutEnvironment
    var language: String
    
    public init(environment: PointCheckoutEnvironment) {
        self.environment = environment
        self.language = Locale.current.languageCode!
    }
    
    public func setLanguage(iso2: String){
        self.language = iso2
    }
    
    public func pay(controller: UIViewController, checkoutKey: String, delegate: PaymentDelegate){
        
        if PointCheckoutUtils.isJailbroken() {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "PointCheckout payment can not run on this device due to security reasons.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            controller.present(alert, animated: true, completion: nil)
            return
        }
        
        let pop = PaymentModal(environment: environment, language: language, checkoutKey: checkoutKey, delegate: delegate)
        controller.view.addSubview(pop)
    }
}

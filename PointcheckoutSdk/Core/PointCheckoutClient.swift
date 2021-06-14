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
    
    public init(environment: PointCheckoutEnvironment) {
        self.environment = environment
    }
    
    public func pay(controller: UIViewController, checkoutKey: String, delegate: PaymentDelegate){
        
        if !validate(controller) {
            return
        }
        
        let pop = PaymentModal(environment: environment, checkoutKey: checkoutKey, delegate: delegate)
        controller.view.addSubview(pop)
    }
    
    private func validate(_ controller: UIViewController) -> Bool {
        if PointCheckoutUtils.isJailbroken() {
            alert(controller, "Error", "PointCheckout payment can not run on this device due to security reasons.")
            return false
        }
        
        return true
    }
    
    
    private func alert(_ controller: UIViewController,_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

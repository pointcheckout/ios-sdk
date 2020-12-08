//
//  PointCheckoutClient.swift
//  PointCheckoutSdk
//
//  Created by Abdullah Asendar on 6/24/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

import UIKit

public class PointCheckoutClient {
        
    public static func pay(controller: UIViewController, paymentUrl: String, delegate: PaymentDelegate){
        
        if !validate(controller, paymentUrl) {
            return
        }
        
        let pop = PaymentModal(paymentUrl: paymentUrl, resultUrl: nil,delegate: delegate)
        controller.view.addSubview(pop)
    }
    
    public static func pay(controller: UIViewController, paymentUrl: String, resultUrl: String, delegate: PaymentDelegate){
        
        if !validate(controller, paymentUrl) {
            return
        }
        
        let pop = PaymentModal(paymentUrl: paymentUrl,resultUrl: resultUrl, delegate: delegate)
        controller.view.addSubview(pop)
    }
    
    private static func validate(_ controller: UIViewController, _ paymentUrl: String) -> Bool {
        if PointCheckoutUtils.isJailbroken() {
            alert(controller, "Error", "PointCheckout payment can not run on this device due to security reasons.")
            return false
        }
        
        if(PointCheckoutEnvironment.getEnviornment(paymentUrl) == nil) {
            alert(controller, "Error", "The provided payment url is invalid")
            return false
        }
        
        return true
    }
    
    
    private static func alert(_ controller: UIViewController,_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

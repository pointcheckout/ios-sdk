//
//  PaymentDelegate.swift
//  pc ios sdk
//
//  Created by Abdullah Asendar on 6/24/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

public protocol PaymentDelegate: AnyObject {
    func onPaymentCancel()
    func onPaymentUpdate()
}

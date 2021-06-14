//
//  PaymentModal.swift
//  PointCheckoutSdk
//
//  Created by Abdullah Asendar on 6/24/19.
//  Copyright © 2019 PointCheckout. All rights reserved.
//

import UIKit
import WebKit

class PaymentModal: UIView, WKNavigationDelegate {
    
    var environment: PointCheckoutEnvironment
    var checkoutKey: String
    var delegate: PaymentDelegate
    
    init(environment: PointCheckoutEnvironment,checkoutKey: String, delegate: PaymentDelegate){
        self.environment = environment
        self.checkoutKey = checkoutKey
        self.delegate = delegate
        super.init(frame: CGRect.zero)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        
        container.addSubview(stack)
        
        webView.load(URLRequest(url: URL(string: self.getPaymentUrl(checkoutKey))!))
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        animateIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            if(webView.url == nil){
                return
            }
            let url = self.webView.url!.absoluteString
            
            print("URL: \(url)")
            
            if isDone(url){
                self.animateOut()
                self.delegate.onUpdate()
            }
        }
    }
    
    func isDone(_ url: String) -> Bool{
        
        let COMPLETE = "/complete";
        let SUCCESS = "/success-redirect";
        let CONFIRMATION = "/payment-confirmation";
        
        return url.hasPrefix(environment.getUrl()  + COMPLETE) ||
            url.hasPrefix(environment.getUrl()  + SUCCESS) ||
            url.hasPrefix(environment.getUrl()  + CONFIRMATION);
    }
    
    func getPaymentUrl(_ checkoutKey: String) -> String {
        return environment.getUrl() + "/checkout/" + checkoutKey;
    }
    
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 15
        return v
    }()
    
    fileprivate let webView: WKWebView = {
        let v = WKWebView()
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        v.layer.cornerRadius = 15;
        v.layer.masksToBounds = true;
        return v
    }()
    
    fileprivate lazy var stack: WKWebView = {
        return self.webView
    }()
    
    @objc fileprivate func dismiss() {
        animateOut()
        delegate.onDismiss()
        
    }
    
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
        
    }
    
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
}

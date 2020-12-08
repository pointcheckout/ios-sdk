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
    
    var redirectUrl: String
    var resultUrl: String?
    var delegate: PaymentDelegate
    var environment: PointCheckoutEnvironment
    
    init(redirectUrl: String,resultUrl: String?, delegate: PaymentDelegate){
        self.redirectUrl = redirectUrl
        self.resultUrl = resultUrl
        self.delegate = delegate
        self.environment = PointCheckoutEnvironment.getEnviornment(redirectUrl)!
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
        
        webView.load(URLRequest(url: URL(string: redirectUrl)!))
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
            
            if paymentComplete(url){
                self.animateOut()
                self.delegate.onPaymentUpdate()
            }
            
            if url.hasPrefix(getBaseUrl() + "/cancel/") {
                self.dismiss()
                
            }
            
        }
    }
    
    func paymentComplete(_ url: String) -> Bool{
        
        let COMPLETE = "/complete/";
        let SUCCESS = "/success-redirect/";
        
        if(self.resultUrl != nil){
            return url.hasPrefix(self.resultUrl!)
        }
        
        return url.hasPrefix(getBaseUrl() + COMPLETE) ||
            url.hasPrefix(getBaseUrl() + SUCCESS);
    }
    
    func getBaseUrl() -> String {
        return environment.getUrl()
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
        delegate.onPaymentCancel()
        
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

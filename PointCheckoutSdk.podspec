Pod::Spec.new do |s|
  s.name         = "PointCheckoutSdk"
  s.version      = "1.2"
  s.summary      = "PointCheckout Merchant Sdk"
  s.description  = "PointCheckout Merchant Sdk used to process payments"
  s.homepage     = "https://github.com/pointcheckout/ios-sdk"
  
  s.license      = { :type => 'PointCheckout', :file => 'LICENSE' }
  s.author       = { "PointCheckout" => "info@pointcheckout.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/pointcheckout/ios-sdk.git", :tag => "#{s.version}" }
  s.source_files =  "PointCheckoutSdk/**/*.swift"
  
  s.swift_version= '5.0'

end

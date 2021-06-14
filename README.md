# PointCheckout Merchant SDK

These are the minimum required steps to use the PointCheckout SDK in your IOS app.

### Getting started

 - Add PointCheckoutSdk pod to your podfile:
 `pod 'PointCheckoutSdk', :git => 'git@github.com:pointcheckout/merchant-ios-sdk.git', :tag=> v${version}`
> replace ${version} with the latest version of the SDK, you can check all available versions [here](https://github.com/pointcheckout/merchant-ios-sdk/releases), example:  `pod 'PointCheckoutSdk', :git => 'git@github.com:pointcheckout/merchant-ios-sdk.git', :tag=> v1.3`
 - Execute `pod install` inside the project directory.
 - Re-build the project.

### Using the SDK
The bellow diagram shows how the payment process works:
![][img_sequence]

[img_sequence]: https://static.staging.pointcheckout.com/17a0c59098aa6528/original

#### Import

You can import the framework using `import PointCheckoutSdk`

#### Checkout request

Send new checkout request to PointCheckout's API (check the [documentation](https://www.pointcheckout.com/en/developers/api/api-integration) for more details). 

#### Payment submit

To submit a payment call the static `pay` function of the `PointCheckoutClient`:

```swift
PointCheckoutClient.pay(controller: viewController, checkoutKey: strCheckoutKey, delegate: callback)
```

| Parameter   | Description                                                      |
|-------------|------------------------------------------------------------------|
| controller  | A UIViewController calling the pay function                      |
| checkoutKey | This key is included in the checkout response from PointCheckout API|
| delegate    | Delegate that will be called on payment update or cancellation   |

Calling the `pay` function will open a modal and the user will be able to login and complete the payment.

#### Payment listener

`PointCheckoutPaymentDelegate` has two callbacks, `onUpdate` and `onDismiss`.

```swift
import UIKit
import PointCheckoutSdk

class ViewController: UIViewController, PointCheckoutPaymentDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func onUpdate(){
        print("UPDATE CALLBACK")
    }
    
    func onDismiss(){
        print("USER CLOSED THE MODAL")
    }
}
```

`onUpdate` will be called whenever the checkout status is updated (paid, cancelled, failed .etc). When this callback is invoked you should call PointCheckout API to fetch the new status of the checkout.

`onDismiss` will only be called if the user closes the modal by clicking on close button.


### Demo app
You can use our Demo app as an example of how to integrate our SDK on your application. you can access it from [here](https://github.com/pointcheckout/ios-sdk-demo). You can import the example app to Xcode and see how the SDK can be used.

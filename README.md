# PC IOS SDK


### Example app
There is an example app at [TDODO: addurl]. You can import the example app to [XCode](https://developer.apple.com/xcode/) to see how the SDK can be used.

### Getting started

 - Download the `.framework` file from here [TODO: addUrl]
 - Add the downloaded file to the embedded binaries of your project.
 - Rebuild your project.

### Using the SDK

First you will need a `checkoutKey` which can be obtained via PointCheckout's API.

#### Import

You can import the framework using `import pc_ios_sdk`

#### Create PointCheckoutClient


Create an object of PointCheckoutClient:

```swift
let client = PointCheckoutClient(environment: PointCheckoutClient.Environment.TEST)

```

<table>  
<tr>
<td>
<b>Parameter</b>
</td>
<td>
<b>Default</b>
</td>
<td>
<b>Description</b>
</td>
</tr>
<tr>
<td>
Environment
</td>
<td>
nil
</td>
<td>
Specifies the environment of the app, use Environment.TEST for testing purposes.
</td>
</tr>
</table>

> Create a single instance of `PointCheckoutClient` and re-use that instance each time you want to checkout.

#### Payment submit

To submit a payment call the `pay` function of the `PointCheckoutClient`:

```swift
let client = PointCheckoutClient(environment: PointCheckoutClient.Environment.TEST)
client.pay(controller: viewController, checkoutKey: strCheckoutKey, delegate: callback)
```

<table>  
<tr>
<td>
<b>Parameter</b>
</td>
<td>
<b>Description</b>
</td>
</tr>

<tr>
<td>
controller
</td>
<td>
A UIViewController calling the pay function
</td>
</tr>

<tr>
<td>
checkoutKey
</td>
<td>
The checkoutKey String value
</td>
</tr>

<tr>
<td>
delegate
</td>
<td>
Delegate that will be called on payment update or cancellation
</td>
</tr>

</table>

Calling the `pay` method will open a modal and the user will be able to login and complete the payment.

#### Payment listener

Use `PointCheckoutPaymentDelegate` to listen for payment updates.

```swift
import UIKit
import pc_ios_sdk

class ViewController: UIViewController, PointCheckoutPaymentDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func onPaymentUpdate(){
        print("UPDATE CALLBACK")
    }
    
    func onPaymentCancel(){
        print("CANCEL CALLBACK")
    }
}
```

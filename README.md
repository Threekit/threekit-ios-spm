# Threekit iOS Swift Package

## Overview

The **Threekit iOS Swift Package** is an iOS SDK that can be used to add a Threekit 2D/3D Player into a iOS app. The package exports two APIs, **ThreekitSDK** and **ThreekitPlayer**.

The **ThreekitSDK** is a class responsible for establishing and maintaining a connection to the Threekit backend, exposing all API functionality to interact with the Threekit Player through the configurator and to manage Threekit state.

The **ThreekitPlayer** is a UI-View component that consumes the instance of the ThreekitSDK and uses a WebView component to render out the Threekit 3D/2D Player.

## Getting Started

## ThreekitSDK

### The Class

The ThreekitSDK is the primary component of the Threekit Framework Package and is required to use the ThreekitPlayer. To instantiate the ThreekitSDK you must provide it with parameters for:

- **assetId** - The assetId of the Threekit Asset or Catalog Item you would like to load in the player
- **authToken** - A Threekit public token.
- **threekitDomain** - The base URL of the threekit environment you are using: i.e. `preview.threekit.com`
- **embedDomain** - The domain associated with the public token being provided

```swift
@StateObject var threekit = ThreekitSDK(
    assetId: "22152326-f3fb-4b19-98f3-9d54436a0ddd", 
    authToken: "34b0d83f-f4c0-41b8-a691-0824e0e9bb16", 
    threekitDomain: "preview.threekit.com",
    embedDomain: "mywebsite.com")
```

In addition to these parameters the ThreekitSDK also accepts all the standard Threekit Javascript Player API parameters used to define the Threekit Players behavior. More information is available for these parameters here: [https://developer.threekit.com/reference/embedding-the-threekit-player](https://developer.threekit.com/reference/embedding-the-threekit-player)

### The Instance

The instance of the ThreekitSDK, contains the configurator API that can be used to build out a UI form for the initialized product that a user can interact with to update the configuration and with it the visuals in the ThreekitPlayer. The configurator API has two parts to it, the **attributes data** and the **setConfigurator method**.

The **attributes** is a stateful data-structure in SwiftyJSON that includes the current state and available configuration options for the initialized product - i.e all data needed to build out the form for the entire user configuration lifecycle. Being stateful, any changes to the configurator will automatically update the attributes state and with it any UI being rendered dynamically from the attributes data. The attributes data-structure mirrors the getDisplayAttributes() output of the Threekit javascript API, more info here: [https://developer.threekit.com/reference/configurator-api#get-display-attributes](https://developer.threekit.com/reference/configurator-api#get-display-attributes).

The **setConfiguration** method is the function used to pass in any change we want to make to the product’s current configuration. These changes will then trigger both an update of the ThreekitPlayer visuals and the attributes state accordingly. This method mirrors then functionality of the **setConfiguration** method on our javascript API, details for which can be found here: [https://developer.threekit.com/reference/configurator-api#set-configuration](https://developer.threekit.com/reference/configurator-api#set-configuration).

```swift
struct ThreekitForm: View {
    //  Instance of the ThreekitSDK
    @ObservedObject var threekit: ThreekitSDK
    
    var body: some View {
        
        VStack {
            //  A Text display of the value of the 'Size' attribute
            Text("Size: \(threekit.attributes?["Size", "value", "name"].string ?? "")")
            

            //  A Button used to select the 2nd value in the 'Size' attribute's
            //  'values' set of options, by using the threekit.setConfiguration method.
						//  Each of the 'values' also includes its current selection state
            Button(action: {
                threekit.setConfiguration(configuration: ["Size": ["assetId": threekit.attributes?["Size", "values", 2, "assetId"].string ?? "Bob"]])
                
            }, label: {
                Text(threekit.attributes?["Size", "values", 2, "name"].string ?? "")})
                .foregroundColor(threekit.attributes?["Size", "values", 2, "selected"].bool ?? false ? Color.green : Color.blue) 
        }

    }
}
```

## ThreekitPlayer

The ThreekitPlayer is the component that visualizes the Threekit 2D/3D player and can be used directly in your View struct by passing it the instance of the ThreekitSDK.

```swift
struct Demo: View {
	  @StateObject var threekit = ThreekitSDK(
		    assetId: "22152326-f3fb-4b19-98f3-9d54436a0ddd", 
		    authToken: "34b0d83f-f4c0-41b8-a691-0824e0e9bb16", 
		    threekitDomain: "preview.threekit.com",
		    embedDomain: "mywebsite.com")
	    
    var body: some View {
	      ThreekitPlayer(threekit: threekit)
    }
}
```

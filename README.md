# BoxKit

Extensions for personal use.

Swift Version: 5.0+
Platforms: iOS

## Installation

### Swift Package Manager

Add the BoxKit package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/utrpanic/box-kit-ios",
        from: "2.2.0"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

### CocoaPods

You can install `BoxKit` via CocoaPods,
by adding the following line to your `Podfile`:

```ruby
pod 'BoxKit', :git => 'https://github.com/utrpanic/box-kit-ios.git', :tag => 'v2.2.0'
```

Run the `pod install` command to download the library
and integrate it into your Xcode project.

## License

BoxKit is released under the MIT license. See [LICENSE](https://github.com/utrpanic/box-kit-ios/blob/master/LICENSE) for details.

# BoxKit

Extensions for personal use.

* Swift 5.0
* Xcode 10.2
* CocoaPods 1.7

### Swift Package Manager

Add the BoxKit package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/utrpanic/box-kit-ios",
        from: "v2.1"
    ),
  ]
)
```

### CocoaPods

You can install `BoxKit` via CocoaPods,
by adding the following line to your `Podfile`:

```ruby
pod 'BoxKit', :git => 'https://github.com/utrpanic/box-kit-ios.git', :tag => 'v2.1'
```

## License

BoxKit is released under the MIT license. [See LICENSE](https://github.com/utrpanic/box-kit-ios/blob/master/LICENSE) for details.

# FreeOpenPortFinder

This framework helps to find an available port for iOS, MacOS, tvOS or iPadOS.

## Adding FreeOpenPortFinder as a Dependency

### Swift Package Manager

Use FreeOpenPortFinder with SPM:

```
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/qustodio/free-open-port-finder.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "<your-target>", dependencies: [
            // other dependencies
            .product(name: "FreeOpenPortFinder", package: "swift-argument-parser"),
        ]),
        // other targets
    ]
)
```



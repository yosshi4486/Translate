# Translate
A publisher that translates all elements from the upstream publisher with provided translator.

## Goal
The goal of this project is **translating publisher's elements** like `decode(type: decoder:)` that Combine provided. **I especially want to support translation for layered architecure data mapping.**

## How to use
### 1. Declare concrete type of `TopLevelTranslator`

```swift
struct IntegerToStringTranslator: TopLevelTranslator {
        
    func translate(from input: Int) -> String {
        return String(input)
    }
}
```

### 2. Use `.translate(translator:)` operator and pass an instance of your concrete translator

```swift
 _ = [1, 2, 3]
            .publisher
            .translate(translator: IntegerToStringTranslator()) // Translate int to string.
            .map { $0.reduce("", { $0 + $1 })} // sum all values in the array.
            .sink { (result) in print(result) }
```

## Requirements
- iOS13, macOS10.15, tvOS 13, or watchOS 6 later
- Swift 5.2
- Xcode11.4

## Instllation
The preferred way of installing **Translate** is via the Swift Package Manager.

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL(`https://github.com/yosshi4486/Translate.git`) and click **Next.**
3. For **Rules**, select Branch(with branch set to `master`).
4. Click **Finish.**

## Contributing
Translate is and will always be free and open. I'd appriciate it if you cloud contribute to this project. 

## License
Translate is licensed under the [MIT License](https://github.com/yosshi4486/Translate/blob/master/README.md)

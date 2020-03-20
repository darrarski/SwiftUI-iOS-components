# ⌨️ Keyboard

Set of SwiftUI components for handling onscreen keyboard.

**Examples:** Each component has corresponding `PreviewProvider` with example usage. Because onscreen keyboard is not visible in Xcode previews, use simulator or physical device to check out the examples.

## 🧩 KeyboardObserver

Observable object that provides current onscreen keyboard state:

- `@Published var frame: CGRect? { get }` - Keyboard frame in global coordinate space or `nil` if keyboard is not visible.
- `@Published var animationDuration: TimeInterval { get }` - Keyboard frame animation duration (defaults to `0` if keyboard was not presented).

It also provides convenience way of dismissing the keyboard by calling `dismiss()` function.

Component can be used by adding `@ObservedObject` property to the view:

```swift
struct SomeView: View {
  @ObservedObject var keyboard = KeyboardObserver()
  ...
}
```

It's recommended to use single `KeyboardObserver` instance per view hierarchy, which can be ensured by using SwiftUI environment objects:

```swift
struct SomeView: View {
  @EnvironmentObject var keyboard: KeyboardObserver
  ...
}

let keyboard = KeyboardObserver()
let view = SomeView().environmentObject(keyboard)
```

- [KeyboardObserver.swift](KeyboardObserver.swift)

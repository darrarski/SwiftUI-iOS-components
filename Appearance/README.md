# ✨ Appearance

Set of SwiftUI components for modifying view appearance.

**Examples:** Each component has corresponding `PreviewProvider` with example usage.

## 🧩 BlurView

Uses `UIVisualEffectView` with `UIBlurEffect` and custom intensity (in range of `0` and `1`) to cover undelaying view with a native iOS blur effect.

In contrast to the native SwiftUI's `.blur` modifier, the `BlurView` blurs everything that's placed behind it, while native `.blur` only affects the view to which is applied.

```swift
ZStack {
  SomeView()
  BlurView(style: .dark, intensity: 0.2)
}
```

- [BlurView.swift](BlurView.swift)


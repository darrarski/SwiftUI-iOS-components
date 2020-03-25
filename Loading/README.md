# ⏳ Loading

Set of SwiftUI components for presenting loading state.

**Examples:** Each component has corresponding `PreviewProvider` with example usage.

## 🧩 ActivityIndicator

SwiftUI wrapper for `UIActivityIndicatorView`.

```swift
ActivityIndicator(style: .large, color: .red)
```

- [ActivityIndicator.swift](ActivityIndicator.swift)

## 🧩 LoadingOverlay

A convenient modifier that blurs the view to which is applied and displays activity indicator on top of it.

```swift
SomeView()
  .loadingOverlay(isActive: true)
```

- [LoadingOverlay.swift](LoadingOverlay.swift)
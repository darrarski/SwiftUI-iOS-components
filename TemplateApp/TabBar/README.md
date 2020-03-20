# 🧩 TabBar

SwiftUI component that allows implementing tabbed user interface (similar to one provided by `UITabBarController`) in a declarative way.

```swift
TabBar {
  TabBarItem(
    icon: Image(systemName: "house.fill"),
    title: "Home",
    action: { ... }
  )
  TabBarItem(
    icon: Image(systemName: "star"),
    title: "Favorites",
    action: { ... }
  )
}
```

For extensive usage example, check out corresponding `PreviewProvider` in [TabBar.swift](TabBar.swift).

- [TabBar.swift](TabBar.swift)
- [TabBarItem.swift](TabBarItem.swift)

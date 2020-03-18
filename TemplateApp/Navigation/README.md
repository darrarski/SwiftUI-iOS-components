# 🧭 Navigation

Set of SwiftUI components that allows implementing declarative navigation between views.

Examples: Each component has corresponding `PreviewProvider` with example usage.

## 🧩 NavigationBackButton

Default back button that can be embedded in `NavigationBar` component. It uses `NavigationDismissAction` to trigger dismission.

```swift
NavigationBackButton()
```

- [NavigationBackButton.swift](NavigationBackButton.swift)

## 🧩 NavigationBar

Default navigation bar that can be embedded in `NavigationItem` component.

```swift
NavigationBar(
  title: { Text("Title") },
  leading: { Text("Leading") },
  trailing: { Text("Trailing") }
)
```

- [NavigationBar.swift](NavigationBar.swift)

## 🧩 NavigationDismissAction

Uses SwiftUI environment to inject navigation dismiss action into view hierarchy. This environment property is used by `NavigationBackButton` and `NavigationPopGesture` to trigger dismission.

```swift
struct SomeView: View {
  @Environment(\.navigationDismissAction) var navigationDismissAction

  var body: some View {
    Button(action: { self.navigationDismissAction() }) {
      Text("Dismiss")
    }
  }
}
```

```swift
SomeView().navigationDismissAction { ... }
```

- [NavigationDismissAction.swift](NavigationDismissAction.swift)

## 🧩 NavigationItem

Navigation item component provides visual representation for a view with navigation bar. The bar can be hidden by injecting `EmptyView`.

```swift
NavigationItem(
  navigationBar: { EmptyView() }, 
  content: { Text("Content") }
)
```

- [NavigationItem.swift](NavigationItem.swift)

## 🧩 NavigationPopGesture

Adds gesture-driven dismission to a view presented using `NavigationPush` component.

```swift
RootView()
  .navigationPush(isActive: isPushed) {
    PushedView()
      .navigationPopGesture()
      .navigationDismissAction { isPushed = false }
  }
```

- [NavigationPopGesture.swift](NavigationPopGesture.swift)

## 🧩 NavigationPush

Allows to push a view on top of current view, imitating `UINavigationController` push action. When navigation takes place, pushed view appears on top of currently visible view, which is not removed from the view hierarchy. 

The component can be used by providing `Bool` value that defines if navigation is active and a closure that returns pushed view:

```swift
var isPushed: Bool

RootView()
  .navigationPush(isActive: isPushed) {
    PushedView()
  }
```

Or by providing a closure that returns optional view that will be pushed if it's not `nil`:

```swift
var model: Model?

struct PushedView: View {
  init(with model: Model) { ... }
  ...
}

RootView()
  .navigationPush {
    model.map(PushedView(with:))
  }
```

- [NavigationPush.swift](NavigationPush.swift)
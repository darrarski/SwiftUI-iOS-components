# 🧩 CollectionView

**`CollectionView`** allows to layout collection of SwiftUI views in a `UICollectionView` style.

```swift
CollectionView(["A", "B", "C"], collectionViewFlowLayout()) { text in
  Text(text)
}
```

Actual layout of the views can be customized by using different `CollectionViewLayout` function. It is a function that accepcts collection of items, dictionary of items sizes and current context geometry proxy, and returns dictionary of items frames:

```swift
typealias CollectionViewLayout<Data: RandomAccessCollection> =
  (Data, [Data.Element: CGSize], GeometryProxy) -> [Data.Element: CGRect]
  where Data.Element: Hashable
```

- [`collectionViewFlowLayout`](CollectionViewFlowLayout.swift) function provides basic flow layout implementaion

For usage example, check out corresponding `PreviewProvider`s.

- [CollectionView.swift](CollectionView.swift)
- [CollectionViewFlowLayout.swift](CollectionViewFlowLayout.swift)

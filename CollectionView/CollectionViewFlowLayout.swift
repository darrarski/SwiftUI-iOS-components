import SwiftUI

func collectionViewFlowLayout<Items>() -> CollectionViewLayout<Items> {
  return { items, sizes, geometry in
    var layout: [Items.Element: CGRect] = [:]
    var bounds: [CGRect] = []
    items.forEach { item in
      let size = sizes[item, default: .zero]
      let rect: CGRect
      if let lastBounds = bounds.last {
        if lastBounds.maxX + size.width > geometry.size.width {
          let origin = CGPoint(x: 0, y: lastBounds.maxY)
          rect = CGRect(origin: origin, size: size)
        } else {
          let origin = CGPoint(x: lastBounds.maxX, y: lastBounds.minY)
          rect = CGRect(origin: origin, size: size)
        }
      } else {
        rect = CGRect(origin: .zero, size: size)
      }
      bounds.append(rect)
      layout[item] = rect
    }
    return layout
  }
}

#if DEBUG
struct CollectionViewFlowLayout_Previews: PreviewProvider {
  static var previews: some View {
    let items = ["Hello", ",", "World", "!", "This", "is", "the", "collection", "flow", "layout", "example", "."]
    return CollectionView(items, collectionViewFlowLayout()) { text in
        Text(text)
          .padding(8)
          .background(Color.orange)
          .cornerRadius(4)
          .padding(4)
    }
  }
}
#endif

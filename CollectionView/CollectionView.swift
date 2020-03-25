import SwiftUI

struct CollectionView<Items: RandomAccessCollection, ItemView: View>: View where Items.Element: Hashable {
  init(_ items: Items,
       _ layoutFunc: @escaping CollectionViewLayout<Items>,
       @ViewBuilder _ itemView: @escaping (Items.Element) -> ItemView) {
    self.items = items
    self.layoutFunc = layoutFunc
    self.itemView = itemView
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .topLeading) {
        ForEach(self.items, id: \.self) { item in
          self.itemView(item)
            .alignmentGuide(.leading, computeValue: { _ in
              -self.layout[item, default: .zero].origin.x
            })
            .alignmentGuide(.top, computeValue: { _ in
              -self.layout[item, default: .zero].origin.y
            })
            .anchorPreference(key: CollectionViewSizePreferences<Items.Element>.self, value: .bounds, transform: {
              [item: geometry[$0].size]
            })
        }
      }.onPreferenceChange(CollectionViewSizePreferences<Items.Element>.self) { sizes in
        self.layout = self.layoutFunc(self.items, sizes, geometry)
      }
    }
  }

  private let items: Items
  private let layoutFunc: CollectionViewLayout<Items>
  private let itemView: (Items.Element) -> ItemView
  @State private var layout: [Items.Element: CGRect] = [:]
}

typealias CollectionViewLayout<Items: RandomAccessCollection> =
  (Items, [Items.Element: CGSize], GeometryProxy) -> [Items.Element: CGRect]
  where Items.Element: Hashable

private struct CollectionViewSizePreferences<Item: Hashable>: PreferenceKey {
  typealias Value = [Item: CGSize]
  static var defaultValue: Value { [:] }
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value.merge(nextValue()) { $1 }
  }
}

#if DEBUG
struct CollectionView_Previews: PreviewProvider {
  static var previews: some View {
    let items = ["Hello", ",", "World", "!", "This", "is", "CollectionView", "example", "."]
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

import SwiftUI

struct VScroll<Content: View>: View {
  init(showsIndicators: Bool = true, @ViewBuilder content: () -> Content) {
    self.showsIndicators = showsIndicators
    self.content = content()
  }

  var showsIndicators: Bool
  var content: Content

  var body: some View {
    GeometryReader { scrollGeometry in
      ScrollView(.vertical, showsIndicators: self.showsIndicators) {
        self.content
          .frame(width: scrollGeometry.size.width)
          .frame(minHeight: scrollGeometry.size.height)
      }
    }
  }
}

#if DEBUG
struct VScroll_Previews: PreviewProvider {
  static var previews: some View {
    VScroll {
      Text("Content")
    }
  }
}
#endif

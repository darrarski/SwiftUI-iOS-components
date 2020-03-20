import SwiftUI

struct NavigationPopGesture: ViewModifier {
  @GestureState var dragOffset: CGFloat = 0
  @Environment(\.layoutDirection) var layoutDirection
  @Environment(\.navigationDismissAction) var navigationDismissAction

  func body(content: Content) -> some View {
    GeometryReader { geometry in
      content
        .offset(x: self.dragOffset, y: 0)
        .gesture(DragGesture(minimumDistance: 8, coordinateSpace: .global)
          .updating(self.$dragOffset, body: { value, state, _ in
            if self.shouldHandleGesture(for: value, geometry, self.layoutDirection) {
              switch self.layoutDirection {
              case .leftToRight:
                state = value.translation.width
              case .rightToLeft:
                state = -value.translation.width
              @unknown default:
                fatalError()
              }
            }
          })
          .onEnded({ value in
            if self.shouldTriggerDismiss(for: value, geometry, self.layoutDirection) {
              self.navigationDismissAction()
            }
          }))
    }
  }

  func shouldHandleGesture(
    for value: DragGesture.Value,
    _ geometry: GeometryProxy,
    _ layoutDirection: LayoutDirection
  ) -> Bool {
    switch layoutDirection {
    case .leftToRight:
      return value.startLocation.x <= 32
    case .rightToLeft:
      return value.startLocation.x >= geometry.frame(in: .global).maxX - 32
    @unknown default:
      fatalError()
    }
  }

  func shouldTriggerDismiss(
    for value: DragGesture.Value,
    _ geometry: GeometryProxy,
    _ layoutDirection: LayoutDirection
  ) -> Bool {
    guard shouldHandleGesture(for: value, geometry, layoutDirection) else {
      return false
    }
    let offset = value.translation.width
    let velocity = value.location.x.distance(to: value.predictedEndLocation.x)
    switch layoutDirection {
    case .leftToRight:
      return offset + velocity >= 128
    case .rightToLeft:
      return offset + velocity <= -128
    @unknown default:
      fatalError()
    }
  }
}

extension View {
  func navigationPopGesture() -> some View {
    modifier(NavigationPopGesture())
  }
}

#if DEBUG
struct NavigationPopGesture_Previews: PreviewProvider {
  struct Preview: View {
    @State var isPushed = false

    var body: some View {
      ZStack {
        Color.yellow.edgesIgnoringSafeArea(.all)
        Button(action: { self.isPushed = true }) {
          Text("Push")
        }
      }.navigationPush(isActive: isPushed) {
        ZStack {
          Color.yellow.edgesIgnoringSafeArea(.all)
          Text("Pushed")
        }.navigationPopGesture()
          .navigationDismissAction { self.isPushed = false }
      }
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif


import SwiftUI

struct NavigationPush<Target: View>: ViewModifier {
  init(isActive: Bool, @ViewBuilder target: () -> Target) {
    self.target = isActive ? target() : nil
  }

  init(@ViewBuilder target: () -> Target?) {
    self.target = target()
  }

  var target: Target?

  func body(content: Content) -> some View {
    ZStack {
      content
        .allowsHitTesting(target == nil)
        .zIndex(1)
      ViewBuilder.buildIf(target.map { target in
        Group {
          Color.black.opacity(0.25)
            .edgesIgnoringSafeArea(.all)
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.25)))
            .zIndex(2)
          target
            .animation(.easeInOut(duration: 0.25))
            .transition(.move(edge: .trailing))
            .zIndex(3)
        }
      })
    }
  }
}


extension View {
  func navigationPush<Target: View>(
    isActive: Bool,
    @ViewBuilder target: @escaping () -> Target
  ) -> some View {
    modifier(NavigationPush(isActive: isActive, target: target))
  }

  func navigationPush<Target: View>(
    @ViewBuilder target: @escaping () -> Target?
  ) -> some View {
    modifier(NavigationPush(target: target))
  }
}

#if DEBUG
struct NavigationPush_Previews: PreviewProvider {
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
          Color.orange.edgesIgnoringSafeArea(.all)
          Button(action: { self.isPushed = false }) {
            Text("Pop")
          }
        }
      }
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif

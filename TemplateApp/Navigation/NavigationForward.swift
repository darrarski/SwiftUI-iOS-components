import SwiftUI

struct NavigationForward<Target: View>: ViewModifier {
  init(isActive: Bool, @ViewBuilder target: () -> Target) {
    self.target = isActive ? target() : nil
  }

  init(@ViewBuilder target: () -> Target?) {
    self.target = target()
  }

  var target: Target?

  func body(content: Content) -> some View {
    ZStack {
      ViewBuilder.buildIf(target == nil
        ? content
          .animation(.easeInOut(duration: 0.25))
          .transition(.move(edge: .leading))
          .zIndex(1)
        : nil
      )
      ViewBuilder.buildIf(target.map { target in
        target
          .animation(.easeInOut(duration: 0.25))
          .transition(.move(edge: .trailing))
          .zIndex(2)
      })
    }
  }
}

extension View {
  func navigationForward<Target: View>(
    isActive: Bool,
    @ViewBuilder target: @escaping () -> Target
  ) -> some View {
    modifier(NavigationForward(isActive: isActive, target: target))
  }

  func navigationForward<Target: View>(
    @ViewBuilder target: @escaping () -> Target?
  ) -> some View {
    modifier(NavigationForward(target: target))
  }
}

#if DEBUG
struct NavigationForward_Previews: PreviewProvider {
  struct Preview: View {
    @State var isForwarded = false

    var body: some View {
      ZStack {
        Color.yellow.edgesIgnoringSafeArea(.all)
        Button(action: { self.isForwarded = true }) {
          Text("Forward")
        }
      }.navigationForward(isActive: isForwarded) {
        ZStack {
          Color.orange.edgesIgnoringSafeArea(.all)
          Button(action: { self.isForwarded = false }) {
            Text("Reverse")
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

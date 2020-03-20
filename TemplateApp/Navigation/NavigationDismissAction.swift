import SwiftUI

typealias NavigationDismissAction = () -> Void

struct NavigationDismissActionKey: EnvironmentKey {
  static let defaultValue: NavigationDismissAction = {}
}

extension EnvironmentValues {
  var navigationDismissAction: NavigationDismissAction {
    get { self[NavigationDismissActionKey.self] }
    set { self[NavigationDismissActionKey.self] = newValue }
  }
}

extension View {
  func navigationDismissAction(_ action: @escaping NavigationDismissAction) -> some View {
    environment(\.navigationDismissAction, action)
  }
}

#if DEBUG
struct NavigationDismissAction_Previews: PreviewProvider {
  struct Preview: View {
    @State var isPushed = false

    var body: some View {
      ZStack {
        Color.yellow.edgesIgnoringSafeArea(.all)
        Button(action: { self.isPushed = true }) {
          Text("Push")
        }
      }.navigationPush(isActive: isPushed) {
        Pushed()
          .navigationDismissAction { self.isPushed = false }
      }
    }
  }

  struct Pushed: View {
    @Environment(\.navigationDismissAction) var navigationDismissAction

    var body: some View {
      ZStack {
        Color.yellow.edgesIgnoringSafeArea(.all)
        Button(action: { self.navigationDismissAction() }) {
          Text("Dismiss")
        }
      }
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif

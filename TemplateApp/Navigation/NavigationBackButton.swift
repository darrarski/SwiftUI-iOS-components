import SwiftUI

struct NavigationBackButton: View {
  @Environment(\.navigationDismissAction) var navigationDismissAction

  var body: some View {
    Button(action: navigationDismissAction) {
      HStack {
        Image(systemName: "chevron.left")
          .flipsForRightToLeftLayoutDirection(true)
        Text("Back")
      }
    }
  }
}

#if DEBUG
struct NavigationBackButton_Previews: PreviewProvider {
  static var previews: some View {
    ZStack(alignment: .top) {
      Color(.systemBackground)
        .edgesIgnoringSafeArea(.all)
      NavigationBar(
        title: { EmptyView() },
        leading: { NavigationBackButton() },
        trailing: { EmptyView() }
      )
    }
  }
}
#endif

import SwiftUI

struct NavigationBar<Title: View, Leading: View, Trailing: View>: View {
  init(@ViewBuilder title: () -> Title, @ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
    self.title = title()
    self.leadingView = leading()
    self.trailingView = trailing()
  }

  var title: Title
  var leadingView: Leading
  var trailingView: Trailing

  var body: some View {
    ZStack {
      Color(UIColor.secondarySystemBackground)
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
        .shadow(radius: 1)
      ZStack {
        title
        HStack(alignment: .firstTextBaseline) {
          leadingView
          Spacer().padding(.horizontal)
          trailingView
        }
      }.padding()
    }.fixedSize(horizontal: false, vertical: true)
  }
}

#if DEBUG
struct NavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    ZStack(alignment: .top) {
      Color(.systemBackground)
        .edgesIgnoringSafeArea(.all)
      NavigationBar(
        title: { Text("Title") },
        leading: { Text("Leading") },
        trailing: { Text("Trailing") }
      )
    }
  }
}
#endif

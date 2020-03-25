import SwiftUI

struct TabBarItem: View {
  var icon: Image
  var title: String
  var action: () -> Void

  var body: some View {
    Button(action: action) {
      VStack(spacing: 0) {
        icon
          .padding(8)
        Text(title)
          .font(.caption)
      }.frame(maxWidth: .infinity)
    }.buttonStyle(PlainButtonStyle())
      .foregroundColor(.accentColor)
  }
}

#if DEBUG
struct TabBarItem_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      TabBarItem(
        icon: Image(systemName: "house"),
        title: "Home",
        action: {}
      ).accentColor(.gray)
      TabBarItem(
        icon: Image(systemName: "house.fill"),
        title: "Home",
        action: {}
      ).accentColor(.accentColor)
    }.previewLayout(.sizeThatFits)
  }
}
#endif

import SwiftUI

struct TabBar<Content: View>: View {
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var content: Content

  public var body: some View {
    HStack(spacing: 8) {
      content
    }.frame(maxWidth: .infinity)
      .background(Color(.secondarySystemBackground)
        .edgesIgnoringSafeArea(.all)
        .shadow(radius: 1))
  }
}

#if DEBUG
struct TabBar_Previews: PreviewProvider {
  enum Tab: String, CaseIterable {
    case home
    case favorites
    case bookmarks

    var title: String { self.rawValue.capitalized }

    var color: Color {
      switch self {
      case .home:
        return Color.blue
      case .favorites:
        return Color.green
      case .bookmarks:
        return Color.purple
      }
    }
  }

  struct Preview: View {
    @State var activeTab = Tab.home

    var body: some View {
      VStack(spacing: 0) {
        if activeTab == .home {
          ZStack {
            Tab.home.color.edgesIgnoringSafeArea(.all)
            Text(Tab.home.title)
          }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.1)))
        }
        if activeTab == .favorites {
          ZStack {
            Tab.favorites.color.edgesIgnoringSafeArea(.all)
            Text(Tab.favorites.title)
          }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.1)))
        }
        if activeTab == .bookmarks {
          ZStack {
            Tab.bookmarks.color.edgesIgnoringSafeArea(.all)
            Text(Tab.bookmarks.title)
          }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.1)))
        }
        TabBar {
          TabBarItem(
            icon: Image(systemName: "house\(activeTab == .home ? ".fill" : "")"),
            title: Tab.home.title,
            action: { self.activeTab = .home }
          ).accentColor(activeTab == .home ? Tab.home.color : .gray)
          TabBarItem(
            icon: Image(systemName: "star\(activeTab == .favorites ? ".fill" : "")"),
            title: Tab.favorites.title,
            action: { self.activeTab = .favorites }
          ).accentColor(activeTab == .favorites ? Tab.favorites.color : .gray)
          TabBarItem(
            icon: Image(systemName: "bookmark\(activeTab == .bookmarks ? ".fill" : "")"),
            title: Tab.bookmarks.title,
            action: { self.activeTab = .bookmarks }
          ).accentColor(activeTab == .bookmarks ? Tab.bookmarks.color : .gray)
        }
      }
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif



import SwiftUI

struct LoadingOverlay: ViewModifier {
  var isActive: Bool
  var color: UIColor?

  func body(content: Content) -> some View {
    content.overlay(
      ZStack {
        if isActive {
          ZStack {
            BlurView(style: .dark, intensity: 0.1)
              .edgesIgnoringSafeArea(.all)
            ActivityIndicator(style: .large, color: color)
              .padding(20)
              .background(Color(.systemBackground)
                .brightness(-0.02)
                .opacity(0.9))
              .cornerRadius(12)
              .shadow(color: Color.primary.opacity(0.5), radius: 2, x: 0, y: 0)
          }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
        }
      }.disabled(!isActive)
    )
  }
}

extension View {
  func loadingOverlay(isActive: Bool, color: UIColor? = nil) -> some View {
    modifier(LoadingOverlay(isActive: isActive, color: color))
  }
}

#if DEBUG
struct LoadingOverlay_Previews: PreviewProvider {
  struct Preview: View {
    @State var isLoading = true

    var body: some View {
      ZStack {
        VStack(spacing: 8) {
          ForEach(Array(1...10), id: \.self) { _ in
            Text("Hello, World! Hello, World!")
          }
        }
      }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .loadingOverlay(isActive: isLoading)
        .onTapGesture { self.isLoading.toggle() }
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif

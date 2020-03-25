import SwiftUI

struct BlurView: UIViewRepresentable {
  var style: UIBlurEffect.Style
  var intensity: CGFloat

  func makeUIView(context: Context) -> UIVisualEffectView {
    let uiView = UIVisualEffectView(effect: nil)
    let effect = UIBlurEffect(style: style)
    context.coordinator.animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak uiView] in
      uiView?.effect = effect
    }
    context.coordinator.animator?.fractionComplete = intensity
    return uiView
  }

  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  class Coordinator {
    var animator: UIViewPropertyAnimator?
  }
}

#if DEBUG
struct BlurView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      VStack(spacing: 8) {
        ForEach(Array(1...10), id: \.self) { _ in
          Text("Hello, World! Hello, World!")
        }
      }
      BlurView(style: .dark, intensity: 0.2)
        .edgesIgnoringSafeArea(.all)
    }
  }
}
#endif

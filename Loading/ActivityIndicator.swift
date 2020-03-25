import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  init(style: UIActivityIndicatorView.Style = .large,
       color: UIColor? = nil) {
    self.style = style
    self.color = color
  }

  var style: UIActivityIndicatorView.Style
  var color: UIColor?

  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let uiView = UIActivityIndicatorView(style: style)
    uiView.startAnimating()
    uiView.color = color
    return uiView
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

#if DEBUG
struct ActivityIndicator_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 16) {
      ActivityIndicator()
      ActivityIndicator(style: .large)
      ActivityIndicator(style: .medium)
      ActivityIndicator(style: .large, color: .red)
      ActivityIndicator(style: .medium, color: .red)
    }.padding(16)
      .previewLayout(.sizeThatFits)
  }
}
#endif

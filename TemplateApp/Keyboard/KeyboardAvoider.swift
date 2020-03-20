import SwiftUI

struct KeyboardAvoider: ViewModifier {
  @EnvironmentObject var keyboard: KeyboardObserver

  func body(content: Content) -> some View {
    GeometryReader { (geometry: GeometryProxy) in
      content
        .padding(.bottom, self.bottomPadding(for: geometry.frame(in: .global)))
        .animation(.easeOut(duration: self.keyboard.animationDuration))
    }
  }

  func bottomPadding(for frame: CGRect) -> CGFloat? {
    guard let keyboardFrame = keyboard.frame else { return nil }
    let padding = frame.maxY - keyboardFrame.minY
    return max(0, padding)
  }
}

extension View {
  func avoidKeyboard() -> some View {
    modifier(KeyboardAvoider())
  }
}

#if DEBUG
struct KeyboardAvoider_Previews: PreviewProvider {
  struct Preview: View {
    @ObservedObject var keyboard = KeyboardObserver()
    @State var text = ""

    var body: some View {
      VStack(alignment: .leading) {
        TextField("TextField", text: $text)
          .padding()
          .border(Color.black, width: 1)
        Button(action: { self.keyboard.dismiss() }) {
          Text("Dismiss keyboard")
            .padding()
            .frame(maxWidth: .infinity)
            .border(Color.accentColor, width: 1)
        }
        Spacer()
      }.padding()
        .border(Color.black, width: 1)
        .padding(4)
        .avoidKeyboard()
        .environmentObject(keyboard)
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif

import Combine
import SwiftUI

final class KeyboardObserver: ObservableObject {

  init(notificationCenter: NotificationCenter = .default) {
    notificationCenter
      .publisher(for: UIResponder.keyboardWillShowNotification)
      .merge(with: notificationCenter.publisher(for: UIResponder.keyboardWillChangeFrameNotification))
      .map { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
      .assign(to: \.frame, on: self)
      .store(in: &cancellables)

    notificationCenter
      .publisher(for: UIResponder.keyboardWillHideNotification)
      .map { _ in nil }
      .assign(to: \.frame, on: self)
      .store(in: &cancellables)

    notificationCenter
      .publisher(for: UIResponder.keyboardWillShowNotification)
      .merge(with: notificationCenter.publisher(for: UIResponder.keyboardWillChangeFrameNotification))
      .merge(with: notificationCenter.publisher(for: UIResponder.keyboardWillHideNotification))
      .map { $0.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval }
      .replaceNil(with: 0)
      .assign(to: \.animationDuration, on: self)
      .store(in: &cancellables)
  }

  @Published private(set) var frame: CGRect?
  @Published private(set) var animationDuration: TimeInterval = 0

  func dismiss() {
    UIApplication.shared
      .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }

  private var cancellables = Set<AnyCancellable>()

}

#if DEBUG
struct KeyboardObserver_Previews: PreviewProvider {
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
        Text("Keyboard frame: \(keyboard.frame.map { String(describing: $0) } ?? "nil")")
        Text("Keyboard animation duration: \(keyboard.animationDuration)")
        Spacer()
      }.padding()
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif

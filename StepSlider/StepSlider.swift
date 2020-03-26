import SwiftUI

struct StepSlider: View {
  var numberOfSteps: Int
  @Binding var currentStep: Int

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(Color.gray)
          .frame(height: self.lineSize)
          .frame(maxWidth: .infinity)
          .padding(.horizontal, self.linePadding)
          .zIndex(1)
        ForEach(Array(0..<self.numberOfSteps), id: \.self) { step in
          Circle()
            .fill(Color.gray)
            .frame(width: self.circleSize, height: self.circleSize)
            .alignmentGuide(.leading, computeValue: { _ in
              self.leading(for: step, in: geometry) + self.circleSize / 2
            })
            .fixedSize()
            .zIndex(2)
        }
        Circle()
          .fill(Color.accentColor)
          .frame(width: self.handleSize, height: self.handleSize)
          .alignmentGuide(.leading, computeValue: { _ in
            self.leading(for: self.currentStep, in: geometry) + self.handleSize / 2
          })
          .fixedSize()
          .zIndex(3)
      }.gesture(DragGesture(minimumDistance: 0)
        .onChanged(self.handleDrag(in: geometry)))
    }.frame(height: max(circleSize, handleSize))
  }

  private let lineSize: CGFloat = 4
  private let circleSize: CGFloat = 16
  private let handleSize: CGFloat = 24

  private var linePadding: CGFloat {
    max(circleSize, handleSize) / 2
  }

  private func lineWidth(in geometry: GeometryProxy) -> CGFloat {
    geometry.size.width - 2 * linePadding
  }

  private func stepWidth(in geometry: GeometryProxy) -> CGFloat {
    lineWidth(in: geometry) / (CGFloat(numberOfSteps) - 1)
  }

  private func leading(for step: Int, in geometry: GeometryProxy) -> CGFloat {
    -1 * (linePadding + CGFloat(step) * stepWidth(in: geometry))
  }

  private func handleDrag(in geometry: GeometryProxy) -> (DragGesture.Value) -> Void {
    return { value in
      let location = value.location.x - self.linePadding
      let percent = min(max(0, location / self.lineWidth(in: geometry)), 1)
      let newStep = Int((percent * CGFloat(self.numberOfSteps - 1)).rounded())
      if newStep != self.currentStep {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
        self.currentStep = newStep
      }
    }
  }
}

#if DEBUG
struct StepSlider_Previews: PreviewProvider {
  struct Preview: View {
    @State var step: Int = 1

    var body: some View {
      VStack {
        Text("Current step: \(step)").animation(nil)
        StepSlider(numberOfSteps: 5, currentStep: $step.animation(.easeInOut(duration: 0.2)))
          .padding()
      }
    }
  }

  static var previews: some View {
    Preview()
  }
}
#endif

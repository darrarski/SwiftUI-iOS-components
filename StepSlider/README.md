# 🧩 StepSlider

Stepped value slider view. It allows adjusting stepped value by the user or for representing step of a onboarding flow etc. When user changes current step value with a drag gesture, haptic feedback is generated on a supported devices.

```swift
@State var currentStep: Int 

StepSlider(
  numberOfSteps: 5, 
  currentStep: $currentStep
)
```

Current step changes can be animated by applying `.animation` modifier to current step binding:

```swift
StepSlider(
  numberOfSteps: 5, 
  currentStep: $currentStep.animation(.easeInOut(duration: 0.2))
)
```

For usage example, check out corresponding `PreviewProvider`s.

- [StepSlider.swift](StepSlider.swift)

import SwiftUI

class RunningCharacterViewModel: ObservableObject {
    @Published var characterPosition: CGFloat = -UIScreen.main.bounds.width / 2
    @Published var currentImageIndex = 0
    private var step: CGFloat = 0
    private let characterImages = ["run_", "run_"]

    init(quizCount: Int) { 
        self.step = UIScreen.main.bounds.width / CGFloat(quizCount)
    }

    func startImageAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            DispatchQueue.main.async {
                self.currentImageIndex = (self.currentImageIndex + 1) % self.characterImages.count
            }
        }
    }

    func moveCharacter() {
        DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.3)) {
                self.characterPosition += self.step
            }
        }
    }
}

import SwiftUI

struct RunningCharacterView: View {
    @State private var characterPosition: CGFloat = -UIScreen.main.bounds.width / 2
    @State private var currentImageIndex = 0
    @State private var step: CGFloat = UIScreen.main.bounds.width / 10
    @State private var progress: Int = 0;
    @State private var isRunning = false

    let characterImages = ["run_1", "run_2"]

    var body: some View {
        VStack {
            
            Button("이동") {
                moveCharacter()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 30)
            
            Spacer()
            
           
            HStack {
                Spacer()

                Image(characterImages[currentImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: characterPosition)
                    .onAppear {
                        startImageAnimation()
                    }

                Spacer()
            }
            .frame(height: 80)
            .padding(.bottom, 0)
        }
    }

    func startImageAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation {
                currentImageIndex = (currentImageIndex + 1) % characterImages.count
            }
        }
    }

    func moveCharacter() {
        guard progress < 10, !isRunning else { return }
        isRunning = true

        withAnimation(.linear(duration: 0.3)) {
            characterPosition += step
        }

        progress += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isRunning = false
        }
    }
}

struct RunningCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        RunningCharacterView()
    }
}

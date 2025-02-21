import SwiftUI

struct RunningCharacterView: View {
    @ObservedObject var viewModel: RunningCharacterViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("run_\(viewModel.currentImageIndex + 1)") // 애니메이션 이미지 변경
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: viewModel.characterPosition)
                    .onAppear {
                        viewModel.startImageAnimation() // 캐릭터 애니메이션 시작
                    }
                Spacer()
            }
            .frame(height: 80)
            .padding(.bottom, 0)
        }
    }
}

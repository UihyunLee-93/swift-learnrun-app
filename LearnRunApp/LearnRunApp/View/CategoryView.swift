import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @State private var showQuizView = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack {
                    Spacer().frame(height: 30)

                    HStack(spacing: 20) {
                        Button(action: {
                            viewModel.changeCategory(to: "swift")
                            showQuizView = true
                        }) {
                            Text("Swift")
                                .frame(width: 155, height: 60)
                                .background(Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            viewModel.changeCategory(to: "it")
                            showQuizView = true
                        }) {
                            Text("IT")
                                .frame(width: 155, height: 60)
                                .background(Color.blue.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 40)

                    NavigationLink(
                        destination: QuizView().environmentObject(viewModel),
                        isActive: $showQuizView
                    ) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var viewModel: QuizViewModel
    @State private var selectedAnswer: String? = nil
    @State private var isAnswerChecked = false
    @State private var showResultView = false
    @StateObject private var characterViewModel: RunningCharacterViewModel
    
    init() {
        _characterViewModel = StateObject(wrappedValue: RunningCharacterViewModel(quizCount: 5))
    }

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let quiz = viewModel.currentQuiz {
                    Text(quiz.question)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    ForEach(quiz.options ?? [], id: \.self) { option in
                        Button(action: {
                            if !isAnswerChecked {
                                selectedAnswer = option
                            }
                        }) {
                            Text(option)
                                .frame(width: 250, height: 50)
                                .background(getButtonColor(for: option))
                                .foregroundColor(selectedAnswer == option ? .white : .blue)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                        .padding(5)
                    }

                    Button(action: {
                        isAnswerChecked = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            characterViewModel.moveCharacter()
                            viewModel.answeredCount += 1
                            if viewModel.answeredCount >= viewModel.quizBatchSize {
                                showResultView = true
                            } else {
                                viewModel.fetchNextQuiz()
                            }
                            resetSelection()
                        }
                    }) {
                        Text("확인")
                            .frame(width: 120, height: 50)
                            .background(isAnswerChecked ? (selectedAnswer == quiz.answer ? Color.green : Color.red) : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .disabled(selectedAnswer == nil)
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $showResultView) {
                ResultView()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)

            RunningCharacterView(viewModel: characterViewModel)
        }
    }

    func getButtonColor(for option: String) -> Color {
        if let quiz = viewModel.currentQuiz, isAnswerChecked {
            if option == quiz.answer {
                return Color.green.opacity(0.7)
            } else if selectedAnswer == option {
                return Color.red.opacity(0.7)
            }
        }
        return selectedAnswer == option ? Color.blue.opacity(0.7) : Color.white
    }

    func resetSelection() {
        selectedAnswer = nil
        isAnswerChecked = false
    }
}

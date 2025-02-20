import SwiftUI


struct QuizCategory {
    var isSwiftSelected: Bool = false
    var isITSelected: Bool = false
}


struct CategoryView: View {
    @State private var quizCategory = QuizCategory()
    @State private var showQuizView = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer().frame(height: 30)

                    HStack(spacing: 20) {
                        Button(action: {
                            quizCategory.isSwiftSelected.toggle()
                            quizCategory.isITSelected = false
                        }) {
                            Text("Swift")
                                .frame(width: 155, height: 60)
                                .background(quizCategory.isSwiftSelected ? Color.blue.opacity(0.7) : Color.white)
                                .foregroundColor(quizCategory.isSwiftSelected ? .white : .blue)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }

                        Button(action: {
                            quizCategory.isITSelected.toggle()
                            quizCategory.isSwiftSelected = false
                        }) {
                            Text("IT")
                                .frame(width: 155, height: 60)
                                .background(quizCategory.isITSelected ? Color.blue.opacity(0.7) : Color.white)
                                .foregroundColor(quizCategory.isITSelected ? .white : .blue)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                    }
                    .padding(.bottom, 40)

                    NavigationLink(destination: QuizView(), isActive: $showQuizView) {
                        Text("Start")
                            .frame(width: 180, height: 50)
                            .background((quizCategory.isSwiftSelected || quizCategory.isITSelected) ? Color.blue : Color.clear)
                            .foregroundColor((quizCategory.isSwiftSelected || quizCategory.isITSelected) ? .white : .blue)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .disabled(!(quizCategory.isSwiftSelected || quizCategory.isITSelected))
                    .padding(.top, 40)

                    Spacer().frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    CategoryView()
}

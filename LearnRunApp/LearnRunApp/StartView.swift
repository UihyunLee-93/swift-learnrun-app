import SwiftUI

struct UserProfile {
    var newData: Bool = false
}

struct StartView: View {
    @State private var userProfile = UserProfile()
    @State private var isButtonPressed = false
    @State private var isUserViewPresented = false //  유저뷰 표시 여부
    @StateObject private var viewModel = QuizViewModel() //viewModel 선언 추가
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text("Learn Run!")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .padding(.bottom, 10)
                    
                    Image("run_")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .padding(.bottom, 30)
                    
                    NavigationLink(destination: CategoryView().environmentObject(userViewModel)) {
                        Text("Start")
                            .frame(width: 160, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserProfileView().environmentObject(userViewModel)) {
                        if let imageData = userViewModel.profileImageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50) // ✅ 크기 키움
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 50, height: 50) // ✅ 크기 키움
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    StartView()
        .environmentObject(UserViewModel())
        .environmentObject(QuizViewModel())
}

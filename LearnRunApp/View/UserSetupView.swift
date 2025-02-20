import SwiftUI

struct UserSetupView: View {
    @StateObject var userViewModel = UserViewModel()
    @State private var userName: String = ""
    @State private var swiftLevel: Int = 0
    @State private var itLevel: Int = 0
    @State private var showUserView = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 프로필 이미지 선택
                Button(action: { showImagePicker = true }) {
                    if let imageData = userViewModel.profileImageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(image: $selectedImage)
                })
                .onChange(of: selectedImage) { newImage in
                    if let newImage = newImage {
                        userViewModel.updateProfileImage(newImage)
                    }
                }

                // 유저 이름 입력
                VStack(alignment: .leading) {
                    Text("이름을 입력하세요")
                        .font(.headline)
                    TextField("이름", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }

                // 레벨 선택
                VStack {
                    LevelSelectionView(title: "Swift Level", selectedLevel: $swiftLevel)
                    LevelSelectionView(title: "IT Level", selectedLevel: $itLevel)
                }

                Spacer()

                // 완료 버튼
                Button(action: {
                    userViewModel.updateUserName(newName: userName)
                    userViewModel.updateSwiftLevel(newLevel: swiftLevel)
                    userViewModel.updateItLevel(newLevel: itLevel)
                    showUserView = true
                }) {
                    Text("완료")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }

                NavigationLink(destination: UserView().environmentObject(userViewModel), isActive: $showUserView) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("프로필 설정")
        }
    }
}

// ImagePicker 뷰
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
struct UserSetupView_Previews: PreviewProvider {
    static var previews: some View {
        UserSetupView()
    }
}

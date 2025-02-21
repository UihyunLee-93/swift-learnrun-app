import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isEditingName = false
    @State private var userName: String
    @State private var showImagePicker = false
    @State private var profileImage: UIImage?
    @State private var showResetAlert = false 

    init() {
        _userName = State(initialValue: UserDefaults.standard.string(forKey: "userName") ?? "TestUser")
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 15) {
                 
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        if let imageData = userViewModel.profileImageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
                    .onChange(of: profileImage) { newImage in
                        if let newImage = newImage {
                            userViewModel.updateProfileImage(newImage)
                        }
                    }

              
                    HStack {
                        if isEditingName {
                            TextField("이름 입력", text: $userName, onCommit: {
                                userViewModel.updateUserName(newName: userName)
                                isEditingName = false
                            })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                        } else {
                            Text(userViewModel.userName)
                                .font(.title2)
                                .fontWeight(.bold)
                        }

                        Button(action: {
                            isEditingName.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                    }

                
                    VStack(alignment: .leading) {
                        Text("수집한 이모지")
                            .font(.headline)
                            .padding(.top, 20)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 4), spacing: 15) {
                            ForEach(userViewModel.emojis, id: \.self) { emoji in
                                Text(emoji)
                                    .font(.largeTitle)
                                    .frame(width: 60, height: 60)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 3)
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()

             
                    Button(action: {
                        showResetAlert = true
                    }) {
                        Text("프로필 초기화")
                            .frame(width: 180, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                    .alert("프로필을 초기화하시겠습니까?", isPresented: $showResetAlert) {
                        Button("취소", role: .cancel) {}
                        Button("초기화", role: .destructive) {
                            userViewModel.deleteProfile()
                            userName = userViewModel.userName
                        }
                    } message: {
                        Text("모든 데이터가 삭제됩니다.")
                    }
                }
                .padding(.top, 50)
            }
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    UserProfileView().environmentObject(UserViewModel())
}

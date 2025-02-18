import SwiftUI

struct ProfileView: View {
    @StateObject var userViewModel = UserViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // 상단: 프로필 이미지 & 유저 정보
            VStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)

                Text(userViewModel.userName)
                    .font(.title)
                    .bold()
            }
            .padding(.top, 20)
            .padding(.bottom,30)

            // 레벨 선택 UI
            VStack(spacing: 15) {
                LevelSelectionView(title: "Swift Level", selectedLevel: $userViewModel.swiftLevel)
                LevelSelectionView(title: "IT Level", selectedLevel: $userViewModel.itLevel)
            }.padding(.bottom, 50)

            // 수집한 오브젝트(메달,이모지)
            VStack(spacing: 15) {
                CollectiblesView(title: "🏅 수집한 메달", items: userViewModel.medals)
                CollectiblesView(title: "😊 수집한 이모지", items: userViewModel.emojis)
            }

            Spacer()

            // 프로필 삭제 버튼
            Button(role: .destructive) {
                userViewModel.deleteProfile()
            } label: {
                Text("프로필 삭제")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 30)
        }
        .padding()
    }
}

// 레벨 선택 UI
struct LevelSelectionView: View {
    let title: String
    @Binding var selectedLevel: Int
    let levels = [0, 1, 2, 3]

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .bold()

            Picker(selection: $selectedLevel, label: Text(title)) {
                ForEach(levels, id: \.self) { level in
                    Text("\(level)").tag(level)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}

// 수집한 아이템 리스트 (메달 & 이모지)
struct CollectiblesView: View {
    let title: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .font(.largeTitle)
                    }
                }
            }
            .frame(height: 50)
        }
        .padding(.horizontal)
    }
}

// SwiftUI 프리뷰
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

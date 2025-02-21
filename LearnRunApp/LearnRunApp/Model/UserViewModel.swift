import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var userName: String {
        didSet { UserDefaults.standard.set(userName, forKey: "userName") }
    }
    @Published var swiftLevel: Int {
        didSet { UserDefaults.standard.set(swiftLevel, forKey: "swiftLevel") }
    }
    @Published var medals: [String] {
        didSet { UserDefaults.standard.set(medals, forKey: "medals") }
    }
    @Published var emojis: [String] {
        didSet { UserDefaults.standard.set(emojis, forKey: "emojis") }
    }
    @Published var profileImageData: Data? {
        didSet {
            UserDefaults.standard.set(profileImageData, forKey: "profileImage")
        }
    }
    
    private let allEmojis = ["😊", "🚀", "🔥", "🌟", "💡", "🎯", "🏆", "🎉"]

    init() {
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? "TestUser"
        self.swiftLevel = UserDefaults.standard.object(forKey: "swiftLevel") as? Int ?? 0
        self.medals = UserDefaults.standard.array(forKey: "medals") as? [String] ?? ["🥇", "🥈", "🥉"]
        self.emojis = UserDefaults.standard.array(forKey: "emojis") as? [String] ?? []
        self.profileImageData = UserDefaults.standard.data(forKey: "profileImage")
    }

  
    func addRandomEmoji() -> String? {
        var availableEmojis = allEmojis.filter { !emojis.contains($0) }
        print(" 지급 가능한 이모지 목록: \(availableEmojis)")

      
        if availableEmojis.isEmpty {
            print(" 모든 이모지를 획득했습니다! 기존 이모지 중 랜덤 지급")
            availableEmojis = allEmojis
        }

   
        if !availableEmojis.isEmpty {
            let randomIndex = Int.random(in: 0..<availableEmojis.count)
            let newEmoji = availableEmojis[randomIndex]
            emojis.append(newEmoji)
            print("🎁 지급된 보상 이모지: \(newEmoji)")
            return newEmoji
        }

        print("❌ 이모지 지급 실패")
        return nil
    }




   
    func addSpecificEmoji(_ emoji: String) {
        if !emojis.contains(emoji) {
            emojis.append(emoji)
        }
    }

  
    func getCollectedEmojis() -> [String] {
        return emojis
    }

    // 이름 변경
    func updateUserName(newName: String) {
        self.userName = newName
    }

    // 메달 추가
    func addMedal(newMedal: String) {
        if !medals.contains(newMedal) {
            self.medals.append(newMedal)
        }
    }

    // 프로필 이미지 변경
    func updateProfileImage(_ image: UIImage) {
        self.profileImageData = image.jpegData(compressionQuality: 0.8)
    }

    // 프로필 삭제 (초기화)
    func deleteProfile() {
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "swiftLevel")
        UserDefaults.standard.removeObject(forKey: "medals")
        UserDefaults.standard.removeObject(forKey: "emojis")
        UserDefaults.standard.removeObject(forKey: "profileImage")

        self.userName = "TestUser"
        self.swiftLevel = 0
        self.medals = ["🥇", "🥈", "🥉"]
        self.emojis = [] // ✅ 초기 이모지 없음
        self.profileImageData = nil
    }
}

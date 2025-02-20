import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var userName: String {
        didSet { UserDefaults.standard.set(userName, forKey: "userName") }
    }
    @Published var swiftLevel: Int {
        didSet { UserDefaults.standard.set(swiftLevel, forKey: "swiftLevel") }
    }
    @Published var itLevel: Int {
        didSet { UserDefaults.standard.set(itLevel, forKey: "itLevel") }
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

    init() {
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? "TestUser"
        self.swiftLevel = UserDefaults.standard.object(forKey: "swiftLevel") as? Int ?? 0
        self.itLevel = UserDefaults.standard.object(forKey: "itLevel") as? Int ?? 0
        self.medals = UserDefaults.standard.array(forKey: "medals") as? [String] ?? ["🥇", "🥈", "🥉"]
        self.emojis = UserDefaults.standard.array(forKey: "emojis") as? [String] ?? ["😊", "🚀", "🔥"]
        self.profileImageData = UserDefaults.standard.data(forKey: "profileImage")
    }
    
    // 이름 변경
    func updateUserName(newName: String) {
        self.userName = newName
    }
    
    // 스위프트 레벨 변경
    func updateSwiftLevel(newLevel: Int) {
        self.swiftLevel = min(3, max(0, newLevel))
    }
    
    // IT 레벨 변경
    func updateItLevel(newLevel: Int) {
        self.itLevel = min(3, max(0, newLevel))
    }
    
    // 메달 추가
    func addMedal(newMedal: String) {
        if !medals.contains(newMedal) {
            self.medals.append(newMedal)
        }
    }
    
    // 이모지 추가
    func addEmoji(newEmoji: String) {
        if !emojis.contains(newEmoji) {
            self.emojis.append(newEmoji)
        }
    }
    
    // 프로필 이미지 변경
    func updateProfileImage(_ image: UIImage) {
        self.profileImageData = image.jpegData(compressionQuality: 0.8)
    }

    // 프로필 삭제
    func deleteProfile() {
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "swiftLevel")
        UserDefaults.standard.removeObject(forKey: "itLevel")
        UserDefaults.standard.removeObject(forKey: "medals")
        UserDefaults.standard.removeObject(forKey: "emojis")
        UserDefaults.standard.removeObject(forKey: "profileImage")

        self.userName = "TestUser"
        self.swiftLevel = 0
        self.itLevel = 0
        self.medals = ["🥇", "🥈", "🥉"]
        self.emojis = ["😊", "🚀", "🔥"]
        self.profileImageData = nil
    }
}

//
//  LearnRunAppApp.swift
//  LearnRunApp
//
//  Created by Uihyun.Lee on 2/17/25.
//

import SwiftUI

@main
struct LearnRunAppApp: App {
    @StateObject private var quizViewModel = QuizViewModel()
    @StateObject private var userViewModel = UserViewModel()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(quizViewModel)
                .environmentObject(userViewModel)
        }
    }
}

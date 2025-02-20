//
//  CollectiblesView.swift
//  LearnRunApp
//
//  Created by Uihyun.Lee on 2/19/25.
//
import SwiftUI

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

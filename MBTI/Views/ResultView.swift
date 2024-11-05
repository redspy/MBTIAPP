//
//  ResultView.swift
//  MBTI
//
//  Created by Minsu Han on 11/5/24.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: MBTITestViewModel

    var body: some View {
        VStack {
            Text("당신의 MBTI 유형은")
                .font(.title)
                .padding(.top, 40)
            
            Text(viewModel.calculateResult())
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            
            Spacer()

            // 초기화 버튼
            Button(action: {
                viewModel.resetTest()
            }) {
                Text("다시 시작하기")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .padding()
        .navigationTitle("결과")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

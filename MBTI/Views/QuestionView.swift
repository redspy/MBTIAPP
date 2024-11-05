//
//  QuestionView.swift
//  MBTI
//
//  Created by Minsu Han on 11/5/24.
//

import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel = MBTITestViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // 질문 텍스트 섹션
                Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                // 답변 버튼 섹션 - "예"와 "아니오" 버튼
                VStack(spacing: 20) {
                    Button(action: {
                        viewModel.selectAnswer(viewModel.questions[viewModel.currentQuestionIndex].options[0]) // "예"에 해당하는 옵션
                    }) {
                        Text("예")
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 16)
                    
                    Button(action: {
                        viewModel.selectAnswer(viewModel.questions[viewModel.currentQuestionIndex].options[1]) // "아니오"에 해당하는 옵션
                    }) {
                        Text("아니오")
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
                
                // 현재 질문 번호 표시
                Text("질문 \(viewModel.currentQuestionIndex + 1) / \(viewModel.questions.count)")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.bottom, 20)
            }
            .padding()
            .navigationTitle("MBTI 테스트")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
            .navigationBarItems(trailing:
                                    NavigationLink(destination: ResultView(viewModel: viewModel), isActive: $viewModel.isTestCompleted) {
                    EmptyView()
                }
            )
        }
    }
}

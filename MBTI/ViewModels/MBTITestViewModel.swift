//
//  MBTITestViewModel.swift
//  MBTI
//
//  Created by Minsu Han on 11/5/24.
//

import SwiftUI
import Foundation

class MBTITestViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var isTestCompleted: Bool = false
    
    private let parser = QuestionParser()
    private var scores: [String: Int] = ["E": 0, "I": 0, "S": 0, "N": 0, "T": 0, "F": 0, "J": 0, "P": 0]

    init() {
        loadQuestions()
    }

    func loadQuestions() {
        // XML 파일에서 질문을 불러오고 파싱합니다
        if let path = Bundle.main.path(forResource: "questions", ofType: "xml"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            self.questions = parser.parse(xmlData: data)
        } else {
            print("XML 파일을 로드하는 데 실패했습니다.")
        }
    }

    func selectAnswer(_ answer: Option) {
        // 사용자가 선택한 답변의 유형 점수를 누적합니다.
        scores[answer.score, default: 0] += 1
        moveToNextQuestion()
    }

    func moveToNextQuestion() {
        // 다음 질문으로 넘어가거나, 마지막 질문일 경우 테스트 완료 상태로 전환합니다.
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            isTestCompleted = true
        }
    }

    func calculateResult() -> String {
        // 누적된 점수를 기준으로 최종 MBTI 유형을 계산하여 반환합니다.
        let result = "\(scores["E"]! >= scores["I"]! ? "E" : "I")" +
                     "\(scores["S"]! >= scores["N"]! ? "S" : "N")" +
                     "\(scores["T"]! >= scores["F"]! ? "T" : "F")" +
                     "\(scores["J"]! >= scores["P"]! ? "J" : "P")"
        return result
    }

    func resetTest() {
        // 테스트를 초기 상태로 되돌립니다.
        currentQuestionIndex = 0
        isTestCompleted = false
        scores = ["E": 0, "I": 0, "S": 0, "N": 0, "T": 0, "F": 0, "J": 0, "P": 0]
    }
}

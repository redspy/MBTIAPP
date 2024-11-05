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
    @Published var resultDescription: String = ""
    
    private let parser = QuestionParser()
    private let descriptionParser = MBTIDescriptionParser()
    private var scores: [String: Int] = ["E": 0, "I": 0, "S": 0, "N": 0, "T": 0, "F": 0, "J": 0, "P": 0]

    init() {
        loadQuestions()
    }

    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "questions", ofType: "xml"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            self.questions = parser.parse(xmlData: data)
            self.questions.shuffle() // 질문 배열을 무작위로 섞어줌
        } else {
            print("XML 파일을 로드하는 데 실패했습니다.")
        }
    }

    func selectAnswer(_ answer: Option) {
        scores[answer.score, default: 0] += 1
        moveToNextQuestion()
    }

    func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            isTestCompleted = true
            loadDescription(for: calculateResult()) // 결과 설명을 로드
        }
    }

    func calculateResult() -> String {
        let result = "\(scores["E"]! >= scores["I"]! ? "E" : "I")" +
                     "\(scores["S"]! >= scores["N"]! ? "S" : "N")" +
                     "\(scores["T"]! >= scores["F"]! ? "T" : "F")" +
                     "\(scores["J"]! >= scores["P"]! ? "J" : "P")"
        return result
    }

    func loadDescription(for type: String) {
        if let path = Bundle.main.path(forResource: "mbti_descriptions", ofType: "xml"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let descriptions = descriptionParser.parse(xmlData: data)
            resultDescription = descriptions[type] ?? "해당 유형에 대한 설명이 없습니다."
        } else {
            resultDescription = "설명 파일을 로드할 수 없습니다."
        }
    }

    func resetTest() {
        currentQuestionIndex = 0
        isTestCompleted = false
        scores = ["E": 0, "I": 0, "S": 0, "N": 0, "T": 0, "F": 0, "J": 0, "P": 0]
        resultDescription = ""
        loadQuestions() // 테스트를 초기화하고 질문을 다시 무작위로 섞어줌
    }
}

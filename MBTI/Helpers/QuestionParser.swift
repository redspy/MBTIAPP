//
//  QuestionParser.swift
//  MBTI
//
//  Created by Minsu Han on 11/5/24.
//

import Foundation

class QuestionParser: NSObject, XMLParserDelegate {
    private var questions: [Question] = []
    private var currentQuestion: Question?
    private var currentOptions: [Option] = []
    private var currentText: String = ""
    private var currentScore: String = ""
    
    func parse(xmlData: Data) -> [Question] {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        return questions
    }
    
    // XMLParserDelegate 메서드들
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {
        case "Question":
            if let idString = attributeDict["id"], let id = Int(idString), let type = attributeDict["type"] {
                currentQuestion = Question(id: id, type: type, text: "", options: [])
                currentOptions = []
            }
        case "Option":
            currentScore = attributeDict["score"] ?? ""
        case "Text":
            currentText = ""
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentText += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "Text":
            currentQuestion?.text = currentText.trimmingCharacters(in: .whitespacesAndNewlines)
        case "Option":
            let option = Option(text: currentText.trimmingCharacters(in: .whitespacesAndNewlines), score: currentScore)
            currentOptions.append(option)
        case "Question":
            if var question = currentQuestion {
                question.options = currentOptions
                questions.append(question)
            }
            currentQuestion = nil
        default:
            break
        }
    }
}


//
//  MBTIDescriptionParser.swift
//  MBTI
//
//  Created by Minsu Han on 11/5/24.
//

import Foundation

class MBTIDescriptionParser: NSObject, XMLParserDelegate {
    private var descriptions: [String: String] = [:]
    private var currentType: String = ""
    private var currentDescription: String = ""
    private var parsingDescription = false
    
    func parse(xmlData: Data) -> [String: String] {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        return descriptions
    }
    
    // XMLParserDelegate 메서드들
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Type", let id = attributeDict["id"] {
            currentType = id
            currentDescription = ""
        } else if elementName == "Description" {
            parsingDescription = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if parsingDescription {
            currentDescription += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Type" {
            descriptions[currentType] = currentDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        } else if elementName == "Description" {
            parsingDescription = false
        }
    }
}

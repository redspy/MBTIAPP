//
//  MBTIApp.swift
//  MBTI
//
//  Created by Minsu Han on 11/5/24.
//

import SwiftUI

@main
struct MBTITestApp: App {
    var body: some Scene {
        WindowGroup {
            QuestionView(viewModel: MBTITestViewModel())
        }
    }
}

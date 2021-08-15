//
//  OnboardingModel.swift
//  OnboardingExample
//
//  Created by Nikita Kazakov on 13.08.2021.
//

import Foundation

final class OnboardingModel {

    func createModels() -> [Onboarding] {
        return [
            Onboarding(index: 1, title: "This is first screen", description: "On this screen will be displaying ither info", imageName: "code")
        ]
    }
}

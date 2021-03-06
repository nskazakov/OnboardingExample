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
            Onboarding(
                index: 0,
                title: "Изучай материалы и выполняй задания",
                description: "Обучения iOS разработке требует много практики, для этого нужно внимательно изучать материалы и выполнять все задания из них. Не забывай повторять примеры, которые показаны в конспектах, так ты быстрее привыкнешь писать код. И да, у нас есть домашние задания, их выполнения и обратная связь по ним очень важны",
                imageName: "code"
            ),
            Onboarding(
                index: 1,
                title: "Задавай возникшие вопросы в чате и на еженедельных созвонах",
                description: "Разбор вопросов - это залог быстрого и правильного обучения. Поэтому если что-то не получается сделать в течении часа задавай свой вопрос в чате",
                imageName: "questions-chat"
            ),
            Onboarding(
                index: 2,
                title: "Опыт реальных собеседований",
                description: "Готовься и проходи собеседования, чтобы в будущем было проще проходить их в реальных компаниях. Так ты сможешь понять, как вообще проходят эти мероприятия и не стрессовать в ненужный момент",
                imageName: "interview"
            )
        ]
    }
}

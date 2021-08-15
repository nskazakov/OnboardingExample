//
//  ViewController.swift
//  OnboardingExample
//
//  Created by Nikita Kazakov on 13.08.2021.
//

import UIKit

final class OnboardingController: UIViewController {

    var model: OnboardingModel?

    /// Это вычисляемое свойство преобразует тип родительской view в OnboardingView
    /// Это делается чтобы мы в будущем могли из Controller'a обращаться к элементам View
    private var onboardingView: OnboardingView? {
        guard isViewLoaded else { return nil }
        return view as? OnboardingView
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Присваиваем значению View наш созданный класс OnboardingView()
        /// Можно это сделать в Main.storyboard, но я решил сделать так
        view = OnboardingView()
        model = OnboardingModel()

        configureView()
    }
}

// MARK: - Configurations

private extension OnboardingController {
    func configureView() {
        guard let models = model?.createModels() else { return }
        onboardingView?.configureView(with: models)
    }
}

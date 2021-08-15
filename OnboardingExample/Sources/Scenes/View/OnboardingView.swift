//
//  OnboardingView.swift
//  OnboardingExample
//
//  Created by Nikita Kazakov on 13.08.2021.
//

import UIKit

final class OnboardingView: UIView {

    // MARK: - Configuration

    func configureView(with models: [Onboarding]) {
        self.models = models
        pageControl.numberOfPages = models.count
        pageControl.currentPage = 0
        selectedIndex = 0
        collectionView.reloadData()
    }

    // MARK: - Private properties

    private var models = [Onboarding]()
    private var selectedIndex = 0 {
        didSet {
            let isLastPage = models.count - 1 > selectedIndex
            buttonView.setTitle(isLastPage
                                    ? Strings.nextButtonTitle
                                    : Strings.startButtonTitle, for: .normal)
            buttonView.backgroundColor = isLastPage
                ? .systemBlue
                : .systemGreen
        }
    }

    // MARK: - Views

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Metric.stackViewSpacing
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false

        view.dataSource = self
        view.delegate = self

        view.register(OnboardingContentViewCell.self,
                      forCellWithReuseIdentifier: OnboardingContentViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.pageIndicatorTintColor = .systemGray5
        view.currentPageIndicatorTintColor = .systemGray

        return view
    }()

    private lazy var buttonView: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = Metric.buttonHeight / 2

        button.addTarget(self, action: #selector(buttonTappedAction(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        addSubview(collectionView)
        addSubview(stackView)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(buttonView)
    }

    private func setupLayout() {
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true

        stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Metric.topOffset).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.leftOffset).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metric.rightOffset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Metric.bottomOffset).isActive = true

        buttonView.heightAnchor.constraint(equalToConstant: Metric.buttonHeight).isActive = true
    }
}

// MARK: - Actions

extension OnboardingView {

    @objc private func buttonTappedAction(_ sender: Any) {

        if models.count - 1 > selectedIndex {
            collectionView.scrollToItem(at: IndexPath(item: selectedIndex + 1, section: 0),
                                        at: .centeredHorizontally, animated: true)

            selectedIndex += 1
            pageControl.currentPage += 1
        } else {
            // TODO: - Implement start app
        }
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingContentViewCell.identifier, for: indexPath) as? OnboardingContentViewCell else { return UICollectionViewCell() }
        cell.configureView(with: models[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let newIndexOfPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = newIndexOfPage
        selectedIndex = newIndexOfPage
    }
}

// MARK: - Constants

extension OnboardingView {

    enum Metric {
        static let buttonHeight: CGFloat = 44
        static let topOffset: CGFloat = 25
        static let leftOffset: CGFloat = 40
        static let rightOffset: CGFloat = -40
        static let bottomOffset: CGFloat = -50

        static let stackViewSpacing: CGFloat = 16
    }

    enum Strings {
        static let nextButtonTitle: String = "Далее"
        static let startButtonTitle: String = "Начать"
    }
}

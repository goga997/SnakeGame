//
//  OnboardingViewController.swift
//  SnakeGame
//
//  Created by Grigore on 27.05.2025.
//

import UIKit

class OnboardingViewController: UIPageViewController {

    private lazy var pages: [UIViewController] = {
        return [
            OnboardingLanguageViewController(),
            OnboardingPage(imageName: "screen1", titleText: "choose_board_title", descriptionText: "choose_board_desc"),
            OnboardingPage(imageName: "screen2", titleText: "avoid_obstacles_title", descriptionText: "avoid_obstacles_desc"),
            OnboardingPage(imageName: "screen3", titleText: "premium_title", descriptionText: "premium_desc", isLastPage: true)
        ]
    }()

    private let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self

        setViewControllers([pages[0]], direction: .forward, animated: true)
        configurePageControl()
        disableSwipeGesture()
    }
    
    private func disableSwipeGesture() {
        for gesture in self.gestureRecognizers {
            gesture.isEnabled = false
        }
    }

    private func configurePageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func goToNextPage() {
        guard let currentVC = viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentVC),
              currentIndex + 1 < pages.count else { return }

        let nextVC = pages[currentIndex + 1]
        setViewControllers([nextVC], direction: .forward, animated: true)
        pageControl.currentPage = currentIndex + 1
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = viewControllers?.first, let index = pages.firstIndex(of: currentVC) else { return }
        pageControl.currentPage = index
    }
}

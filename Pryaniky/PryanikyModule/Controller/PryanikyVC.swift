//
//  PryanikyVC.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import UIKit

class PryanikyVC: UIViewController {

    // MARK: - Property
    var pryanikyView = PryanikyView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink

        setupNavigationController()
        setupAddSubview()
        setupScrollViewConstraint()
        setupStackViewConstraint()
    }

    // MARK: - Private Methods

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pryaniky"
    }

    func setupAddSubview() {
        view.addSubview(pryanikyView.scrollView)
    }

    private func setupScrollViewConstraint() {
        let frameLayoutGuide = pryanikyView.scrollView.frameLayoutGuide

        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }

    private func setupStackViewConstraint() {
        let contentLayoutGuide = pryanikyView.scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            pryanikyView.stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 5),
            pryanikyView.stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -5),
            pryanikyView.stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 10),
            pryanikyView.stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -5),
            pryanikyView.stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}


//
//  PryanikyView.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import UIKit

class MainView: UIView {

    // MARK: - UI Element

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()

}

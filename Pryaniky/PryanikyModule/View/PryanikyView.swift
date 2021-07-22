//
//  PryanikyView.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import UIKit

class PryanikyView: UIView {

    // MARK: - UI Element

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .darkGray
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topTextView,
                                                       segmentedControl,
                                                       imageView,
                                                       botTextView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        return stackView
    }()

    lazy var topTextView: UITextView = {
        var textView = UITextView()
        textView.text = "Hello, world"
        textView.textAlignment = .center
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
        return textView
    }()

    lazy var segmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl()
        return segmentedControl
    }()

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var botTextView: UITextView = {
        var textView = UITextView()
        textView.text = "Hello, world"
        textView.textAlignment = .center
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
        return textView
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeightUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHeightUI()
    }

    // MARK: - Private Methods

    private func setupHeightUI() {
        NSLayoutConstraint.activate([
            topTextView.heightAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            botTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}

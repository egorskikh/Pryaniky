//
//  TextBlockView.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 22.07.2021.
//

import UIKit

class TextBlockView: UIView {

    lazy var textBlock: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255/255, green: 154/255, blue: 25/255, alpha: 1.0)
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = .white
        return label
    }()

    private var tapViewCallback: (() -> Void)?

    // MARK: - Life Cycle

    init(tapViewCallback: @escaping () -> Void) {
        super.init(frame: .zero)
        self.tapViewCallback = tapViewCallback
        setupConstraint()
        addTap()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        addTap()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupConstraint() {
        self.addSubview(textBlock)

        NSLayoutConstraint.activate([
            textBlock.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textBlock.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textBlock.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            textBlock.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            textBlock.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func addTap() {
        let selector = #selector(self.viewlDidTapped)
        self.addGTapRecognizer(selector: selector)
    }

    @objc private func viewlDidTapped() {
        tapViewCallback?()
    }

    // MARK: - Public Methods

    public func setTextContent(content: HzModel) {
        textBlock.text = content.text 
    }

}

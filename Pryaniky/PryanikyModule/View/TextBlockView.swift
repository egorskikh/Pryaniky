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
        label.backgroundColor = .lightGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = .white
        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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

    // MARK: - Public Methods

    func setTextContent(content: HzModel) {
        textBlock.text = content.text 
    }

}

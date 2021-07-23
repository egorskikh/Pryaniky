//
//  SelectorView.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 22.07.2021.
//

import UIKit

class SelectorView: UIView {

    private var segmentControl: UISegmentedControl?

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private var selector: SelectorModel?
    private var tapViewCallback: ((_ index: Int) -> Void)?

    init(tapViewCallback: @escaping (_ index: Int) -> Void) {
        super.init(frame: .zero)
        self.tapViewCallback = tapViewCallback
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Action

    @objc private func indexChanged() {
        guard
            let segmentControl = segmentControl,
            let content = selector
        else {
            return
        }
        
        let index = segmentControl.selectedSegmentIndex
        label.text = content.variants[index].text
        tapViewCallback?(index)
    }

    // MARK: - Public Methods

    public func setSegmentedTextContent(_ content: SelectorModel) {
        self.selector = content
        createSegmentControl(content: content)
        setupConstraint()
        label.text = content.variants[content.selectedId].text
    }

    // MARK: - Private Methods

    private func setupConstraint() {

        guard let segmentControl = segmentControl else { return }

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmentControl)
        self.addSubview(label)

        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            label.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

    }

    private func createSegmentControl(content: SelectorModel)  {
        var segmentItems = [String]()
        content.variants.forEach {
            segmentItems.append(String($0.id))
        }
        let segmentControl = UISegmentedControl(items: segmentItems)
        segmentControl.selectedSegmentIndex = content.selectedId
        segmentControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        self.segmentControl = segmentControl
    }

}

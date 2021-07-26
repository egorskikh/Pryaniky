//
//  PryanikyVC.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import UIKit

class PryanikyVC: UIViewController {

    // MARK: - Property
    
    private var mainView = MainView()
    private var viewModel = PryanikyViewModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupScrollViewConstraint()
        setupStackViewConstraint()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showViewsFromJSON()
    }

    // MARK: - Private Methods

    private func showViewsFromJSON() {
        viewModel.networkDataFetcher.fetchJSON { dataJSON in
            guard let dataJSON = dataJSON else { return }

            let viewsArray = dataJSON.views
            let data = dataJSON.data

            viewsArray.forEach {
                let view = $0

                let model: ContentDataModel? = data.first { model -> Bool in
                    model.title == view
                }

                guard
                    let body = model?.body,
                    let title = model?.title
                else {
                    return

                }

                switch view {
                case "hz":
                    if let hz: HzModel = body.getContent() {
                        let view = TextBlockView() { [weak self] in
                            self?.viewModel.didTappedView(title: title)
                        }
                        view.setTextContent(content: hz)
                        self.mainView.stackView.addArrangedSubview(view)
                    }
                case "picture":
                    if let picture: PictureModel = body.getContent() {
                        let view = ImageView() { [weak self] in
                            self?.viewModel.didTappedView(title: title)
                        }
                        view.showContent(content: picture)
                        self.mainView.stackView.addArrangedSubview(view)
                    }
                case "selector":
                    if let selector: SelectorModel = body.getContent() {
                        let view = SelectorView() { [weak self] index in
                            self?.viewModel.didTappedView(id: index, title: title)
                        }
                        view.setSegmentedTextContent(selector)
                        self.mainView.stackView.addArrangedSubview(view)
                    }
                default:
                    print("Ops... missed the show VIEW")
                    break
                }
            }
        }
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pryaniky"
        view.backgroundColor = UIColor(red: 255/255, green: 154/255, blue: 25/255, alpha: 1.0)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

    private func setupScrollViewConstraint() {
        view.addSubview(mainView.scrollView)
        let frameLayoutGuide = mainView.scrollView.frameLayoutGuide

        NSLayoutConstraint.activate([
            frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }

    private func setupStackViewConstraint() {
        let contentLayoutGuide = mainView.scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            mainView.stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor, constant: 5),
            mainView.stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor, constant: -5),
            mainView.stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 10),
            mainView.stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -5),
            mainView.stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}


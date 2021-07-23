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
        fetchJSON()
    }

    // MARK: - Private Methods

    private func fetchJSON() {
        viewModel.networkDataFetcher.fetchJSON { data in
            guard let data = data else { return }
            self.showViewsFromJSONFile(forData: data)
        }
    }

    private func showViewsFromJSONFile(forData viewsDataModel: ResponseDataModel) {
        let viewsArray = viewsDataModel.views
        let data = viewsDataModel.data

        viewsArray.forEach {
            let view = $0
            let model: ContentDataModel? = data.first { model -> Bool in
                model.title == view
            }

            guard let contentModel = model?.body else { return }

            switch view {
            case "hz":
                if let hz: HzModel = contentModel.getContent() {
                    let view = TextBlockView() { [weak self] in
                        self?.viewModel.didTappedView(title: model?.title)
                    }
                    view.setTextContent(content: hz)
                    mainView.stackView.addArrangedSubview(view)
                }
            case "picture":
                if let picture: PictureModel = contentModel.getContent() {
                    let view = ImageView() { [weak self] in
                        self?.viewModel.didTappedView(title: model?.title)
                    }
                    view.showContent(content: picture)
                    mainView.stackView.addArrangedSubview(view)
                }
            case "selector":
                if let selector: SelectorModel = contentModel.getContent() {
                    let view = SelectorView() { [weak self] index in
                        self?.viewModel.didTappedView(id: index, title: model?.title)
                    }
                    view.setSegmentedTextContent(selector)
                    mainView.stackView.addArrangedSubview(view)
                }
            default:
                break
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


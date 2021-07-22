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
    private var networkDataFetcher = NetworkDataFetcher()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupAddSubview()
        setupScrollViewConstraint()
        setupStackViewConstraint()

        networkDataFetcher.fetchJSON { data in
            guard let data = data else { return }
            print(data)
            self.showSuccessViews(forData: data)
        }
    }

    private func showSuccessViews(forData viewsDataModel: ResponseDataModel) {

        let viewsArray = viewsDataModel.views
        let views = viewsDataModel.data

        viewsArray.forEach {
            let name = $0
            let model: ContentDataModel? = views.first { model -> Bool in
                model.title == name
            }

            guard let contentModel = model?.body else { return }

            switch name {
            case "hz":
                if let hz: HzModel = contentModel.getContent() {
                    let view = TextBlockView()
                    print("This is HZ: \(hz)")
                    view.setTextContent(content: hz)
                    mainView.stackView.addArrangedSubview(view)
                }
            case "picture":
                if let picture: PictureModel = contentModel.getContent() {
                    print("This is PICTURE: \(picture)")
                    let view = ImageView()
                    view.showContent(content: picture)
                    mainView.stackView.addArrangedSubview(view)
                }
            case "selector":
                if let selector: SelectorModel = contentModel.getContent() {
                    print("This is SELECTOR: \(selector)")
                    let view = SelectorView()
                    view.setSegmentedTextContent(selector)
                    mainView.stackView.addArrangedSubview(view)
                }
            default:
                break
            }
        }
    }

    // MARK: - Private Methods

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pryaniky"
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.7447180133, blue: 0.8628635712, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func setupAddSubview() {
        view.addSubview(mainView.scrollView)
    }

    private func setupScrollViewConstraint() {
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


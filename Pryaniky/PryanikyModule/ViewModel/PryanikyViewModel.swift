//
//  PryanikyViewModel.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import UIKit

class PryanikyViewModel: PryanikyViewModelType {

    public var networkDataFetcher = NetworkDataFetcher()

    func didTappedView(id: Int?, title: String?) {
        var message: String? = nil

        if let id = id, let title = title {
            message = "selectedId - \(String(id)), view - \(title)"
        } else if id == nil, let title = title {
            message = "view - \(title)"
        }
        guard let message = message else { return }
        print(message)
    }

}



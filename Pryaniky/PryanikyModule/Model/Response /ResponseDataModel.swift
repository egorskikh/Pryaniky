//
//  ResponseDataModel.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 22.07.2021.
//

import Foundation

struct ResponseDataModel: Decodable {

    let data: [ContentDataModel]
    let views: [String]

    enum CodingKeys: String, CodingKey {
        case data
        case views = "view"
    }

}

struct ContentDataModel: Decodable {

    let title: String
    let body: BodyContent?

    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case body = "data"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)

        switch title {
        case "hz":
            let contentData = try? container.decode(HzModel.self, forKey: .body)
            self.body = contentData.map { BodyDataModel(data: $0) }
        case "picture":
            let contentData = try? container.decode(PictureModel.self, forKey: .body)
            self.body = contentData.map { BodyDataModel(data: $0) }
        case "selector":
            let contentData = try? container.decode(SelectorModel.self, forKey: .body)
            self.body = contentData.map { BodyDataModel(data: $0) }
        default:
            self.body = nil
        }

    }
}

protocol BodyContent: Decodable  {
    func getContent<T: Decodable>() -> T?
}

struct BodyDataModel<T: Decodable>: BodyContent {

    let data: T

    func getContent<R>() -> R? where R: Decodable {
        return (data as? R)
    }
}

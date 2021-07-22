//
//  NetworkDataFetcher.swift
//  Pryaniky
//
//  Created by Egor Gorskikh on 21.07.2021.
//

import Foundation

final class NetworkDataFetcher {

    private var networkService = NetworkService()

    public func fetchJSON(completion: @escaping (ResponseDataModel?) -> ()) {
        networkService.request() { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: ResponseDataModel.self, from: data)
            completion(decode)
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()

        guard let data = from else { return nil }

        do {
            let objects = try decoder.decode(type.self, from: data)
            print("Successfule FETCHED from JSON.")
            return objects
        } catch let jsonError {
            print("FAILED to decode JSON: \(jsonError)", jsonError.localizedDescription)
            return nil
        }
    }

}

//
//  NetworkService.swift
//  Navigation
//
//  Created by Филипп Степанов on 25.08.2022.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        guard let url = configuration.url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print(String(data: data, encoding: .windowsCP1251) ?? "")
            }
            if let response = response as? HTTPURLResponse {
                print("1 \(response.allHeaderFields),2 \(response.statusCode)")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

enum AppConfiguration {
    case people
    case starships
    case planets
    
    var url: URL? {
        switch self {
        case .people:
            return URL(string: "https://swapi.dev/api/people/8")
        case .starships:
            return URL(string: "https://swapi.dev/api/starships/3")
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/5")
        }
    }
}

//
//  InfoViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 03.08.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    var buttonDelete: CustomButton = {
        let button = CustomButton(title: "Удалить все", titleColor: .white, backgroundColor: .clear)
        button.frame = CGRect(x: 100, y: 350, width: 200, height: 50)
        return button
    }()
    
    private var titleLabel: UILabel = {
        var title = UILabel()
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    private var planetLabel:  UILabel = {
        var planet = UILabel()
        planet.textAlignment = .center
        planet.numberOfLines = 0
        return planet
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        fetchTitle()
        fetchOrbitalPeriiod()
    }
    
    private func setViews() {
        view.addSubview(buttonDelete)
        view.addSubview(titleLabel)
        view.addSubview(planetLabel)
        titleLabel.frame = CGRect(x: 10, y: 20, width: view.bounds.width - 20, height: 60)
        planetLabel.frame = CGRect(x: 10, y: 20 + titleLabel.bounds.height + 20, width: view.bounds.width - 20, height: 60)
        view.backgroundColor = .systemGray
        buttonDelete.onTap = { [ weak self ] in
            self?.tap()
        }
    }
    
     private func tap() {
         coordinator?.showAlertModule(controller: self)
     }
    
    private func fetchTitle() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            do {
                if let data = data {
                    let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
                    if let dictionary = object as? [[String:Any]] {
                        let title = dictionary.randomElement()?["title"] as? String
                        DispatchQueue.main.async {
                            self.titleLabel.text = title
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func fetchOrbitalPeriiod() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let planetInstans = try decoder.decode(PlanetInstans.self, from: data)
                DispatchQueue.main.async {
                    self.planetLabel.text = planetInstans.orbitalPeriod
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }


}

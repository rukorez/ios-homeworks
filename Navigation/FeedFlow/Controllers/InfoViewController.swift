//
//  InfoViewController.swift
//  Navigation
//
//  Created by Филипп Степанов on 03.08.2021.
//

import UIKit

final class InfoViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    private lazy var colors = FeedFlowColors()
    
    private var residentNames: [String] = []
    
    private var buttonDelete: CustomButton = {
        let button = CustomButton(title: NSLocalizedString("infoViewDeleteButtonTitle", comment: ""), titleColor: .white, backgroundColor: .clear)
        button.frame = CGRect(x: 100, y: 350, width: 200, height: 50)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var planetLabel:  UILabel = {
        var planet = UILabel()
        planet.textAlignment = .center
        planet.numberOfLines = 0
        return planet
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        fetchTitle()
        fetchOrbitalPeriiod()
        fetchResidentNames()
    }
    
    private func setViews() {
        view.addSubview(buttonDelete)
        view.addSubview(titleLabel)
        view.addSubview(planetLabel)
        view.addSubview(tableView)
        titleLabel.frame = CGRect(x: 10, y: 20, width: view.bounds.width - 20, height: 60)
        planetLabel.frame = CGRect(x: 10, y: 20 + titleLabel.bounds.height + 20, width: view.bounds.width - 20, height: 60)
        tableView.frame = CGRect(x: 0, y: 350 + buttonDelete.bounds.height + 10, width: view.bounds.width,
                                 height: view.bounds.height - (350 + buttonDelete.bounds.height + 10))
        view.backgroundColor = colors.infoViewBackgroundColor
        buttonDelete.onTap = { [ weak self ] in
            self?.tap()
        }
    }
    
     private func tap() {
         coordinator?.showAlertModule(controller: self)
     }

}

// Реализация парсинга JSON

extension InfoViewController {
    
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
                    self.planetLabel.text = "The planet \(planetInstans.name) has orbital period is \(planetInstans.orbitalPeriod)"
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func fetchResidentNames() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let planetInstans = try decoder.decode(PlanetInstans.self, from: data)
                planetInstans.residents.forEach { resident in
                    let residentUrl = URL(string: resident)
                    guard let residentUrl = residentUrl else { return }
                    let task = URLSession.shared.dataTask(with: residentUrl) { data, response, error in
                        do {
                            guard let data = data else { return }
                            let resident = try JSONDecoder().decode(Resident.self, from: data)
                            self.residentNames.append(resident.name)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } catch {
                            print(error)
                        }
                    }
                    task.resume()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

// Настройка UITableView

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residentNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = residentNames[indexPath.row]
        return cell
    }
    
}

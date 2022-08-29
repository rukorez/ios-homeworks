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
    
    private var titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        fetchTitle()
    }
    
    private func setViews() {
        view.addSubview(buttonDelete)
        view.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 10, y: 20, width: view.bounds.width - 20, height: 30)
        titleLabel.textAlignment = .center
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


}

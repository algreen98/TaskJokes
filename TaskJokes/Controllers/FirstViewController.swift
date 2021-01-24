//
//  FirstViewController.swift
//  TaskJokes
//
//  Created by mac on 23.01.2021.
//

import UIKit

class FirstViewController: UIViewController {

    let tableView = UITableView()
    let loadButton = UIButton()
    let countTextField = UITextField()
    var numberOfRows: Int = 0
    
    var resultFromAPI: APIManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Jokes"
        outlets()
        tableViewCreating()
    }
    
    func outlets() {
        view.addSubview(loadButton)
        view.addSubview(countTextField)
        
        loadButton.setTitle("LOAD", for: .normal)
        loadButton.backgroundColor = .systemBlue
        loadButton.layer.cornerRadius = 15
        
        countTextField.placeholder = "Input count..."
        countTextField.delegate = self
        countTextField.textAlignment = NSTextAlignment.center
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        countTextField.translatesAutoresizingMaskIntoConstraints = false
        
        loadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        loadButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loadButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        countTextField.bottomAnchor.constraint(equalTo: loadButton.topAnchor, constant: -20).isActive = true
        countTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        countTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        countTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        loadButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    func tableViewCreating() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: countTextField.topAnchor, constant: -20).isActive = true
    }

    @objc func buttonAction() {
        security()
        loadData()
        tableView.reloadData()
    }
    
    func loadData () {
        let urlString = "http://api.icndb.com/jokes/random/200"
        let url = URL(string: urlString)
        guard url != nil else { return }
        
        do {
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let result = try decoder.decode(APIManager.self, from: data)
            resultFromAPI = result
        } catch {
            print (error)
        }
    }
    
    func security() {
        if countTextField.text == "" {
            numberOfRows = 0
            countTextField.placeholder = "Click here!"
        } else if countTextField.text != "" {
            numberOfRows = Int(countTextField.text!)!
            countTextField.placeholder = "Input count..."
            print (numberOfRows)
        }
    }

}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = resultFromAPI!.value[indexPath.row].joke
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.sizeToFit()
        return cell
    }
}

extension FirstViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
          let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
          let components = string.components(separatedBy: inverseSet)
          let filtered = components.joined(separator: "")
          return string == filtered
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//
//  ViewController.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import UIKit

class MainVC: UIViewController {

    let tableView = UITableView()
    
    var repos : [Repo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()

    }

    // MARK: Listeners
    @objc private func rightMenuTapped(){
        
    }
    
}

extension MainVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reuseID, for: indexPath) as! TrendingCell
        
        cell.set(repo: repos[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repos[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}

// MARK: UI Setup
extension MainVC{
    private func configureVC(){
        view.backgroundColor = .systemBackground
        
        let menuDotsImage = UIImage.menuIcon.withRenderingMode(.alwaysTemplate)
        let menuButton = UIBarButtonItem(image: menuDotsImage, style: .plain, target: self, action: #selector(rightMenuTapped))
        self.navigationItem.rightBarButtonItem  = menuButton
        navigationController?.navigationBar.tintColor = .darkGray
        
        title = StringConstants.trending
        
    }
    
    private func configureUI(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TrendingCell.self, forCellReuseIdentifier: TrendingCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func layoutUI(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
    
}


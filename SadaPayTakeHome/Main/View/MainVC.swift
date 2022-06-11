//
//  ViewController.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import UIKit

class MainVC: UIViewController {

    let tableView = UITableView()
    
    var viewModel : MainViewModel
    
    required init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureUI()
        layoutUI()
        viewModel.getTrendingData()
    }

    // MARK: Listeners
    @objc private func rightMenuTapped(){
        
    }
    
    
}

extension MainVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reuseID, for: indexPath) as! TrendingCell
        
        cell.set(repo: viewModel.repos[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.repos[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension MainVC: MainViewModelDelegate{
    func updateLoader(isLoading: Bool) {
        if isLoading{
            print("Loading Data")
        }else{
            print("Done Loading Data")
        }
    }
    
    func showError(error: String) {
        
    }
    
    func receivedData() {
        tableView.reloadData()
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


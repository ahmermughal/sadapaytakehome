//
//  ViewController.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import UIKit
import Lottie
class MainVC: UIViewController {
    
    let tableView = UITableView()
    let retryButton = SadaButton(borderColor: .systemGreen, title: StringConstants.retryButtonTitle)
    let errorView = UIView()
    let animationView = AnimationView(name: "error_anim")
    let errorTitleLabel = UILabel()
    let errorDescriptionLabel = UILabel()
    
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
        layoutErrorView()
        viewModel.getTrendingData()
    }
    
    // MARK: Listeners
    @objc private func rightMenuTapped(){
        viewModel.getTrendingData()
    }
    
    @objc private func retryButtonTapped(){
        hideErrorView()
        viewModel.getTrendingData()
        
    }
    
    // MARK: Functions
    private func showErrorView(){
        tableView.isHidden = true
        animationView.play()
        animationView.loopMode = .loop
        errorView.isHidden = false
    }
    
    private func hideErrorView(){
        tableView.isHidden = false
        errorView.isHidden = true
        animationView.stop()
    }
    
    
}

extension MainVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isLoading ? 10 : viewModel.repos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.reuseID, for: indexPath) as! TrendingCell
        if !viewModel.isLoading{
            cell.set(repo: viewModel.repos[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isLoading ? 80 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.repos[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setTemplateWithSubviews(viewModel.isLoading, animate: true, viewBackgroundColor: .systemBackground)
    }
}

extension MainVC: MainViewModelDelegate{
    func updateLoader(isLoading: Bool) {
        if isLoading{
            tableView.isUserInteractionEnabled = false
            tableView.reloadData()
        }else{
            tableView.isUserInteractionEnabled = true
            tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        showErrorView()
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
        
        errorView.isHidden = true
        errorTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        errorTitleLabel.adjustsFontForContentSizeCategory = true
        errorDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        errorDescriptionLabel.adjustsFontForContentSizeCategory = true
        
        errorDescriptionLabel.textColor = .secondaryLabel
        errorTitleLabel.textAlignment = .center
        errorDescriptionLabel.textAlignment = .center
        
        errorTitleLabel.text = StringConstants.errorTitle
        errorDescriptionLabel.text = StringConstants.errorDescription
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    private func layoutUI(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func layoutErrorView(){
        
        let views = [animationView, errorTitleLabel, errorDescriptionLabel, retryButton]
        
        for item in views{
            item.translatesAutoresizingMaskIntoConstraints = false
            errorView.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            
            animationView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: errorView.centerYAnchor, constant: -100),
            animationView.heightAnchor.constraint(equalToConstant: 300),
            animationView.widthAnchor.constraint(equalToConstant: 260),
            
            errorTitleLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            errorTitleLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 16),
            errorTitleLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -16),
            
            errorDescriptionLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 16),
            errorDescriptionLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 16),
            errorDescriptionLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -16),
            
            retryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            retryButton.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 16),
            retryButton.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -16),
            retryButton.heightAnchor.constraint(equalToConstant: 55)
            
        ])
        
    }
    
}


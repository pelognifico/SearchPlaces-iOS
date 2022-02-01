//
//  MainViewController.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 27/1/22.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func displayNearbyPlaces(viewModel: MainModel.GetNearbyPlaces.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: MainModel.Error.ViewModel, on queu: DispatchQueue)
}

class MainViewController: BaseViewController {
    
    @IBOutlet weak var placesTableView: UITableView!
    
    let cellPlacesNibName = "PlacesTableViewCell"
    
    var dataPlaces: [NearbyPlaces]?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
        settingTableView()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        refresher.endRefreshing()
        getNearbyPlaces(ll: "47.608013,-122.335167")
    }
    
    func getNearbyPlaces(ll: String) {
        let request = MainModel.GetNearbyPlaces.Request(ll: ll)
        interactor?.getNearbyPlaces(request: request)
    }
    
    // Configure CellView in HardwareViewController
    private func settingTableView() {
        placesTableView.register(UINib(nibName: cellPlacesNibName, bundle: nil),
                           forCellReuseIdentifier: PlacesTableViewCell.reuseIdentifier)
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        placesTableView.rowHeight = UITableView.automaticDimension
        placesTableView.refreshControl = refresher
    }
    
    // MARK: - Actions
    @IBAction func searchOnClick(_ sender: Any) {
        let viewCtrl = SearchPlacesViewController()
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }
    
}

// MARK: - MainDisplayLogic
extension MainViewController: MainDisplayLogic {
    func displayNearbyPlaces(viewModel: MainModel.GetNearbyPlaces.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        print("Todo bien")
        dataPlaces = viewModel.placesList
        
        placesTableView.reloadData()
    }
    
    func displayError(viewModel: MainModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    // Show rows of the table depend status variable bool
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPlaces?.count ?? 0
    }
    
    // Show cells of the table depend status variable bool
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PlacesTableViewCell else {
                                                        fatalError()
        }
        
        let process = dataPlaces?[indexPath.row]
        if let data = process {
            cell.configUI(nearbyPlaces: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtrl = PlacesDetailsViewController()
        viewCtrl.nearbyPlaces = dataPlaces?[indexPath.row]
        viewCtrl.fsq_id = dataPlaces?[indexPath.row].fsq_id
        
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }
}

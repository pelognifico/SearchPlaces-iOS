//
//  SearchPlacesViewController.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 31/1/22.
//

import UIKit

protocol SearchPlacesDisplayLogic: AnyObject {
    func displayAutocomplete(viewModel: SearchPlacesModel.GetAutocomplete.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: SearchPlacesModel.Error.ViewModel, on queu: DispatchQueue)
}

class SearchPlacesViewController: BaseViewController {
    
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var searchPlacesTextField: SPTextField! {
        didSet {
            searchPlacesTextField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    let cellSearchPlacesNibName = "SearchPlacesTableViewCell"
    var dataPlaces: [SearchPlaces]?
    var text: String?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: SearchPlacesBusinessLogic?
    var router: (NSObjectProtocol & SearchPlacesRoutingLogic & SearchPlacesDataPassing)?

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
        let interactor = SearchPlacesInteractor()
        let presenter = SearchPlacesPresenter()
        let router = SearchPlacesRouter()
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
        setupBackButton()
        settingTableView()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        refresher.endRefreshing()
    }
    
    func getAutocomplete(query: String, ll: String) {
        hideLoading()
        let request = SearchPlacesModel.GetAutocomplete.Request(query: query, ll: ll)
        interactor?.getAutocomplete(request: request)
    }
    
    // Configure CellView in HardwareViewController
    private func settingTableView() {
        placesTableView.register(UINib(nibName: cellSearchPlacesNibName, bundle: nil),
                           forCellReuseIdentifier: SearchPlacesTableViewCell.reuseIdentifier)
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        placesTableView.rowHeight = UITableView.automaticDimension
        placesTableView.refreshControl = refresher
    }
    
    private func search() {
        if searchPlacesTextField.text?.isEmpty == true {
            placesTableView.isHidden = true
        } else {
            placesTableView.isHidden = false
            if let text = searchPlacesTextField?.text?.lowercased() {
                getAutocomplete(query: text, ll: "47.608013,-122.335167")
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        search()
    }

}

// MARK: - SearchPlacesDisplayLogic
extension SearchPlacesViewController: SearchPlacesDisplayLogic {
    func displayAutocomplete(viewModel: SearchPlacesModel.GetAutocomplete.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        dataPlaces?.removeAll()
        if viewModel.placesList?.count ?? 0 > 0 {
            dataPlaces = viewModel.placesList
            
            refresher.endRefreshing()
            placesTableView.reloadData()
        }
        
    }
    
    func displayError(viewModel: SearchPlacesModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchPlacesViewController: UITableViewDelegate, UITableViewDataSource{
    // Show rows of the table depend status variable bool
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPlaces?.count ?? 0
    }
    
    // Show cells of the table depend status variable bool
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlacesTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? SearchPlacesTableViewCell else {
                                                        fatalError()
        }
        
        let process = dataPlaces?[indexPath.row]
        if let data = process {
            cell.configUI(places: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtrl = PlacesDetailsViewController()
        viewCtrl.places = dataPlaces?[indexPath.row]
        viewCtrl.fsq_id = dataPlaces?[indexPath.row].place?.fsq_id
        viewCtrl.isSelectedSearchPlaces = true
        
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }
}

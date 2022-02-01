//
//  PlacesDetailsViewController.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import UIKit

protocol PlacesDetailsDisplayLogic: AnyObject {
    func displayDetailsPlaces(viewModel: PlacesDetailsModel.GetDetailsPlaces.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: PlacesDetailsModel.Error.ViewModel, on queu: DispatchQueue)
}

class PlacesDetailsViewController: BaseViewController {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dmaLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var postCodeLabel: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    
    var nearbyPlaces: NearbyPlaces?
    
    var places: SearchPlaces?
    var isSelectedSearchPlaces: Bool = false
    
    var detailsPlaces: [PlacesDetailsModel.GetDetailsPlaces.Response]?
    var prefix: String?
    var suffix: String?
    var photo: String?
    var fsq_id: String?
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: PlacesDetailsBusinessLogic?
    var router: (NSObjectProtocol & PlacesDetailsRoutingLogic & PlacesDetailsDataPassing)?

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
        let interactor = PlacesDetailsInteractor()
        let presenter = PlacesDetailsPresenter()
        let router = PlacesDetailsRouter()
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
        loadInitialData()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        refresher.endRefreshing()
        getNearbyPlaces(fsq_id: fsq_id ?? "")
        
        if isSelectedSearchPlaces == true {
            //Data SearchPlaces
            nameLabel.text = places?.place?.name
            addressLabel.text = "\(places?.place?.location?.address ?? ""), \(places?.place?.location?.address_extended ?? "")"
            countryLabel.text = "\(places?.place?.location?.country ?? ""), \(places?.place?.location?.region ?? "")"
            dmaLabel.text = places?.place?.location?.dma ?? ""
            localityLabel.text = places?.place?.location?.locality ?? ""
            postCodeLabel.text = places?.place?.location?.postcode ?? ""
            timeZoneLabel.text = "America/Los Angeles"
        } else {
            // Data MainViewController
            nameLabel.text = nearbyPlaces?.name
            addressLabel.text = "\(nearbyPlaces?.location?.address ?? ""), \(nearbyPlaces?.location?.address_extended ?? "")"
            countryLabel.text = "\(nearbyPlaces?.location?.country ?? ""), \(nearbyPlaces?.location?.region ?? "")"
            dmaLabel.text = nearbyPlaces?.location?.dma ?? ""
            localityLabel.text = nearbyPlaces?.location?.locality ?? ""
            postCodeLabel.text = nearbyPlaces?.location?.postcode ?? ""
            timeZoneLabel.text = "America/Los Angeles"
        }

    }
    
    func getNearbyPlaces(fsq_id: String) {
        let request = PlacesDetailsModel.GetDetailsPlaces.Request(fsq_id: fsq_id)
        interactor?.getDetailsPlaces(request: request)
    }
    
}

// MARK: - PlacesDetailsDisplayLogic
extension PlacesDetailsViewController: PlacesDetailsDisplayLogic {
    func displayDetailsPlaces(viewModel: PlacesDetailsModel.GetDetailsPlaces.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        detailsPlaces = viewModel.data
        fsq_id = nearbyPlaces?.fsq_id
        fsq_id = places?.place?.fsq_id
        
        detailsPlaces?.forEach({ i in
            photo = "\(i.prefix ?? "")original\(i.suffix ?? "")"
        })
        pictureImageView.setImage(urlString: photo, imageView: pictureImageView)
    }
    
    func displayError(viewModel: PlacesDetailsModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }

}

//
//  PlacesTableViewCell.swift
//  SearchPlaces
//
//  Created by Carlos Villamizar on 28/1/22.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var namePlaceLabel: UILabel!
    @IBOutlet weak var categoryPlaceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    static let reuseIdentifier = "PlacesCell"
    var photo: String?
    var categoryName: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configUI(nearbyPlaces: NearbyPlaces) {
        nearbyPlaces.categories?.forEach({ i in
            photo = "\(i.icon?.prefix ?? "")120\(i.icon?.suffix ?? "")"
            categoryName = i.name
        })
        pictureImageView.setImage(urlString: photo, imageView: pictureImageView)
        namePlaceLabel.text = nearbyPlaces.name
        categoryPlaceLabel.text = categoryName
        distanceLabel.text = "\(nearbyPlaces.distance ?? 0) M"
    }
}

//
//  SearchPlacesTableViewCell.swift
//  SearchPlaces
//
//  Created by Ruben Duarte on 31/1/22.
//

import UIKit

class SearchPlacesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    static let reuseIdentifier = "SearchPlacesCell"
    var photo : String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configUI(places: SearchPlaces) {
        titleLabel.text = places.place?.name
        places.place?.categories?.forEach({ i in
            photo = "\(i.icon?.prefix ?? "")100\(i.icon?.suffix ?? "")"
            categoryLabel.text = i.name
        })
        pictureImageView.setImage(urlString: photo, imageView: pictureImageView)
    }
    
}

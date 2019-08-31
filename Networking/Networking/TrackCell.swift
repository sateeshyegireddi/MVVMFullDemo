//
//  TrackCell.swift
//  Networking
//
//  Created by Sateesh Yegireddi on 24/08/19.
//  Copyright © 2019 Company. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var artistURLLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: TrackCellViewModel? {
        didSet {
            artistNameLabel.text = viewModel?.artistName
            artistURLLabel.text = viewModel?.artistURL
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(artistURLLabel)

        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistURLLabel.translatesAutoresizingMaskIntoConstraints = false

        artistNameLabel.anchor(top: contentView.topAnchor,
                               leading: contentView.leadingAnchor,
                               bottom: artistURLLabel.topAnchor,
                               trailing: contentView.trailingAnchor,
                               padding: UIEdgeInsets(top: 12, left: 12, bottom: 8, right: 12))
        artistURLLabel.anchor(top: artistNameLabel.bottomAnchor,
                               leading: artistNameLabel.leadingAnchor,
                               bottom: contentView.bottomAnchor,
                               trailing: artistNameLabel.trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
}

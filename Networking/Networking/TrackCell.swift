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
    
    var viewModel: TrackCellViewModel? {
        didSet {
            artistNameLabel.text = viewModel?.artistName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

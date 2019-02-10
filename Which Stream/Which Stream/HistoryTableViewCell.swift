//
//  HistoryTableViewCell.swift
//  Which Stream
//
//  Created by Leo Oliveira on 12/9/18.
//  Copyright © 2018 Whcih. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    var isMovie = false
    var isTelevision = false
    var isAnime = false
    
    var mediaBackground: UIImageView = {
        let background = UIImageView()
        background.image = nil
        background.alpha = 0.3
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    let mediaName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.text = ""
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let mediaSeasonEp: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = ""
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let mediaEpName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.text = ""
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        // Format elements
        
        // Add elements as subviews
        addSubview(mediaBackground)
        addSubview(mediaName)
        addSubview(mediaSeasonEp)
        addSubview(mediaEpName)
        
        // Add constraints to elements
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

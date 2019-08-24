//
//  YearlyRecordCell.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class YearlyRecordCell: UITableViewCell {
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: YearlyRecord) {
        self.yearLabel.text = data.year
        self.volumeLabel.text = String(data.totalVolume)
        self.indicatorImage.isHidden = !data.hasDescreasingVolume
    }
    
}

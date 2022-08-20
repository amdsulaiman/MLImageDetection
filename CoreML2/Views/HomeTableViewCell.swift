//
//  HomeTableViewCell.swift
//  CoreML2
//
//  
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    static let identifier = "HomeTableViewCell"
    @IBOutlet weak var baseView: RCustomView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var iconimg: UIImageView!
    @IBOutlet weak var nextImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "HomeTableViewCell", bundle: nil)
    }

}

//
//  RecordingCell.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit

class RecordingCell: UITableViewCell {

    let playImage = UIImage(systemName: SFSymbols.play)
    let deleteImage = UIImage(systemName: SFSymbols.delete)
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBAction func onButtonPlayPress(_ sender: Any) {
        
    }
    
    @IBAction func onButtonDeletePress(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        btnPlay.setImage(playImage, for: .normal)
        btnPlay.setTitle("", for: .normal)
        btnDelete.setImage(deleteImage, for: .normal)
        btnDelete.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

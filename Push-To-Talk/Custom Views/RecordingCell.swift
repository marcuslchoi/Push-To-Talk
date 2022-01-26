//
//  RecordingCell.swift
//  Push-To-Talk
//
//  Created by Marcus Choi on 1/24/22.
//

import UIKit

class RecordingCell: UITableViewCell {

    let playImage = UIImage(systemName: SFSymbols.play)
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        btnPlay.setImage(playImage, for: .normal)
        btnPlay.setTitle("", for: .normal)
        btnDelete.setTitle(Alert.deleteButtonTitle, for: .normal)
        btnDelete.setTitleColor(.white, for: .normal)
        btnDelete.layer.backgroundColor = UIColor.systemRed.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

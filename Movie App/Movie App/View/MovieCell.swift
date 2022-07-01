//
//  MovieCell.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 28/06/22.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func fetchPoster(path: String){
        let url = URL(string: K.networking.imageUrl + path)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.posterImage.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}

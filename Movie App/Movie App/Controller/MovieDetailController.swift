//
//  MovieDetailController.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 29/06/22.
//

import UIKit

class MovieDetailController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var titleString: String?
    var overviewString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = titleString
        overviewLabel.text = overviewString

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

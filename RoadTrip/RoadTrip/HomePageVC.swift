//
//  1HomePageVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/3/20.
//

import Foundation

class HomePageVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        hello.text = "Hi \(user.name)"
    }
    @IBOutlet weak var hello: UILabel!
}

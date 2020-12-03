//
//  createNameVC.swift
//  RoadTrip
//
//  Created by Chanmin Park on 12/3/20.
//

import Foundation

class CreateNameVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var username: String = ""
    @IBAction func goToApp(_ sender: Any) {
        self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}

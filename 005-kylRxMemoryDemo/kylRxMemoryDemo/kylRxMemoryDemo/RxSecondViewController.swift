//
//  RxSecondViewController.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/22.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit

class RxSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTestCircleRetain(_ sender: Any) {
        navigationController?.pushViewController(KCHomeViewController(), animated: true)
    }
    
    @IBAction func btnTagClicked(_ sender: Any) {
        self.navigationController?.pushViewController(KTestTagViewController(), animated: true)
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

//
//  ZooListViewController.swift
//  Zoo
//
//  Created by Paweł on 30/09/2022.
//

import UIKit

protocol ZooListViewControllerDelegate: AnyObject {

    func ZooListViewControllerDelegateDidSelect(_ zooListViewController: ZooListViewController, animal: Animal)
}


final class ZooListViewController: UIViewController {

    weak var delegate: ZooListViewControllerDelegate?
    
    private var listView: ZooListView {
        return view as! ZooListView
    }

    override func loadView() {
        super.loadView()
        view = ZooListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

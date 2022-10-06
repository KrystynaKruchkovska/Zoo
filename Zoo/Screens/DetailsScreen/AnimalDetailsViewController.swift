//
//  AnimalDetailsViewController.swift
//  Zoo
//
//  Created by Paweł on 05/10/2022.
//

import UIKit
import Combine

class AnimalDetailsViewController: UIViewController {

    private var viewModel: AnimalDetailsViewModelProtocol
    private var tokens = Set<AnyCancellable>()
    
    var customView: DetailsView {
        return view as! DetailsView
    }
    init(viewModel: AnimalDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = DetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupImage()
        // Do any additional setup after loading the view.
    }
    

    private func setupImage() {
        viewModel.fetchImage()
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { [weak self] image in
//            self?.progressIndicator.stopAnimating()
            self?.customView.imageView.image = image
        })
        .store(in: &tokens)
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

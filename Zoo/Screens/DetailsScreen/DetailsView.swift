//
//  DetailsView.swift
//  Zoo
//
//  Created by Paweł on 05/10/2022.
//

import UIKit

class DetailsView: UIView {
    private var animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
        super.init(frame: .zero)
        setupTextViewText()
        self.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        setupConstraints()
        updateStackView(with: UIScreen.main.bounds.size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, label, emptyView])
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emptyView: UIView = {
        return UIView()
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .white
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            mainStackView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 400),
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 400),
            label.widthAnchor.constraint(greaterThanOrEqualTo: imageView.widthAnchor)
        ])
    }
    
    func setupTextViewText() {
        label.text = "Name: \(animal.name)" + "\n"
        + "Latin name: \(animal.latinName)" + "\n"
        + "Geo range: \(animal.geoRange)" + "\n"
        + "Diet: \(animal.diet)" + "\n"
        + "Life span: \(animal.lifespan)" + "\n"
        + "Max weight: \(animal.weightMax)" + "\n"
        + "Min weight: \(animal.weightMin)" + "\n"
        + "Active time: \(animal.activeTime.rawValue)" + "\n"
    }
    
    func updateStackView(with size: CGSize) {
        let orintation: UIDeviceOrientation = size.width > size.height ? .landscapeRight : .portrait
   
        switch orintation {
        case .portrait:
            self.mainStackView.axis = .vertical
            self.mainStackView.alignment = .center
            
        case .landscapeRight:
            self.mainStackView.axis = .horizontal
            self.mainStackView.alignment = .center
            
        default:
            self.mainStackView.axis = .vertical
            self.mainStackView.alignment = .center
        }
    }
}

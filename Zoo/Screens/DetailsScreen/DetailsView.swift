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
        self.addSubview(mainStackView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            label.widthAnchor.constraint(equalTo: imageView.widthAnchor)
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
}

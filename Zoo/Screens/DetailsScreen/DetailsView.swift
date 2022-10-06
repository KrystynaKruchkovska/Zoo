//
//  DetailsView.swift
//  Zoo
//
//  Created by Paweł on 05/10/2022.
//

import UIKit

class DetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        mainStackView.frame = bounds
        setupConstraints()
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, textView])
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
    
    var textView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
}

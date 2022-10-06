import UIKit
import Combine

class AnimalTableViewCell: UITableViewCell {

    private var imageDownloader: ImageDownloaderProtocol?
    private var tokens = Set<AnyCancellable>()
    static var reusableIdentifier: String {
        return String(describing: self)
    }

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       self.addSubview(mainStackView)
       progressIndicator.startAnimating()
   }
       // Configure the view for the selected state
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       progressIndicator.frame = CGRect(x: imgView.frame.width/2, y: imgView.frame.height/2, width: 20, height: 20)
       imgView.addSubview(progressIndicator)
       setupConstraints()
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        progressIndicator.startAnimating()
    }

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView, label])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imgView.setContentHuggingPriority(.defaultLow, for: .vertical)

        return imgView
    }()

    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    let progressIndicator: UIActivityIndicatorView = {
        let progressIndicator = UIActivityIndicatorView()
        progressIndicator.color = .green
        return progressIndicator
    }()

    func update(with imageURL: URL, imageDownloader: ImageDownloaderProtocol?) {
        self.imageDownloader = imageDownloader
        downloadImage(with: imageURL)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            imgView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            imgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
        ])
    }
}

extension AnimalTableViewCell {
   func downloadImage(with url: URL) {
       imageDownloader?.download(with: url)
               .receive(on: DispatchQueue.main)
               .sink(receiveValue: { [weak self] image in
                   self?.imgView.image = image
                   self?.progressIndicator.stopAnimating()
               })
               .store(in: &tokens)
   }
}

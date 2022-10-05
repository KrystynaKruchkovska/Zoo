import UIKit
import Combine

class AnimalTableViewCell: UITableViewCell {

    private var imageDownloader: ImageDownloaderProtocol?
    private var imageDowloadingID: UUID?
    private var tokens = Set<AnyCancellable>()
    static var reusableIdentifier: String {
        return String(describing: self)
    }

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
//       mainStackView.addArrangedSubview()
       self.addSubview(mainStackView)

   }

       // Configure the view for the selected state
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       progressIndicator.frame = CGRect(x: imgView.frame.width/2, y: imgView.frame.height/2, width: 20, height: 20)
       setupConstraints()
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        guard let imageDowloadingID = imageDowloadingID else {
            return
        }
        imageDownloader?.cancelTask(for: imageDowloadingID)
        progressIndicator.startAnimating()
    }

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView, label])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
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
        return progressIndicator
    }()

    func update(with imageURL: URL, imageDownloader: ImageDownloaderProtocol?) {
        self.imageDownloader = imageDownloader
        downloadImage(with: imageURL)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imgView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            imgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension AnimalTableViewCell {
   func downloadImage(with url: URL) {
//       imageDowloadingID =
       imageDownloader?.download(with: url)
               .receive(on: DispatchQueue.main)
               .sink(receiveValue: { [weak self] image in
                   print("HERE", image.description)
                   self?.imgView.image = image
               })
               .store(in: &tokens)
   }
}

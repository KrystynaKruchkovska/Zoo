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
       mainStackView.frame = self.bounds
       self.addSubview(mainStackView)
   }

       // Configure the view for the selected state
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       progressIndicator.frame = CGRect(x: imgView.frame.width/2, y: imgView.frame.height/2, width: 20, height: 20)
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
        let stackView = UIStackView(arrangedSubviews: [label, imgView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        return imgView
    }()

    var label: UILabel = {
        let label = UILabel()
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
        observeFetchedImage()
    }
}

extension AnimalTableViewCell {
   func downloadImage(with url: URL) {
       imageDowloadingID = imageDownloader?.download(with: url)
   }
    
    func observeFetchedImage() {
        imageDownloader?.fetchedImage
            .receive(on: RunLoop.main)
            .sink { [weak self] image in
                print("HERE", image.description)
                self?.imageView?.image = image
            }
            .store(in: &tokens)
    }
}

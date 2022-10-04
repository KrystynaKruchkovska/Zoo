import UIKit

class AnimalTableViewCell: UITableViewCell {


//    private var imageDownloader: ImageDownloaderProtocol?

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

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView, label])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
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

    func update(with imageURL: URL) {
//        self.imageDownloader = imageDownloader
        downloadImage(with: imageURL)
    }
}

extension AnimalTableViewCell {
   func downloadImage(with URL: URL) {
//       imageDownloader?.download(with: URL, completionHandler: { [weak self] result in
//           DispatchQueue.main.async {
//               self?.progressIndicator.stopAnimating()
//               switch result {
//               case let .success(image):
//                   self?.imgView.image = image
//               case .failure:
//                   print("ProductTableViewCell:downloadImage - failed to download image")
//               }
//           }
//       })
   }
}

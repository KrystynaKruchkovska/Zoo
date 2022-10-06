//
//  AnimalDetailsViewModel.swift
//  Zoo
//
//  Created by Paweł on 05/10/2022.
//

import Combine
import UIKit

protocol AnimalDetailsViewModelProtocol {
    var animal: Animal { get }
    func fetchImage() -> Future<UIImage?, Never>
}
class AnimalDetailsViewModel: AnimalDetailsViewModelProtocol {
    
    private (set) var animal: Animal
    private (set) var imageDownloader: ImageDownloaderProtocol
    private var tokens = Set<AnyCancellable>()
    
    
    
    init(animal: Animal, imageDownloader: ImageDownloaderProtocol) {
        self.animal = animal
        self.imageDownloader = imageDownloader
    }
    
    func fetchImage() -> Future<UIImage?, Never> {
        Future { [weak self] promise in
            
            guard let self = self else {
                return
            }
            guard let imgUrl = URL(string: self.animal.imageLink) else {
                return promise(.success(nil))
            }
            self.imageDownloader.download(with: imgUrl)
                .sink { image in
                    return promise(.success(image))
                }.store(in: &self.tokens)
        }
    }

    
}

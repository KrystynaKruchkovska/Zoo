//
//  ZooTests.swift
//  ZooTests
//
//  Created by Paweł on 07/10/2022.
//

import XCTest
import Combine

@testable import Zoo

final class NetworkingEngineTests: XCTestCase {
    
        var sut: ImageDownloaderProtocol!
        var cancellables = Set<AnyCancellable>()
        var fakeImageCache: FakeImageCache!
        var networkingEngine: NetworkingEngineProtocol!
    
    override func setUp() {
        //        sut = FakeNetworkingEngine()
        fakeImageCache = FakeImageCache()
        networkingEngine = NetworkingEngine()
        sut = ImageDownloader(networkingEngine: networkingEngine, imageCache: fakeImageCache)
        
    }
    
    func test_decodeJson_withCorrectData_shouldReturnObject() {
        let data = """
                        {"name":"Green Basilisk","latin_name":"Basiliscus                       plumifrons","animal_type":"Reptile","active_time":"Diurnal","length_min":"2"                        ,"length_max":"3","weight_min":"0.5","weight_max":"0                        .6","lifespan":"10","habitat":"Tropical rainforest","diet":"Seeds, fruit,                       leaves, insects and other small animals","geo_range":"Central                       America","image_link":"https://upload.wikimedia                     .org/wikipedia/commons/f/f3/Green_Basilisk%2C_Alajuela%2C_Costa_Rica                        .jpg","id":80}
                        """.data(using: .utf8)
        
        let object = try! JSONDecoder().decode(Animal.self, from: data!)
        XCTAssertNotNil(object)
    }
        
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

extension UIImage {

    /// Creates an image of a desired size, filled with a provided color.
    ///
    /// - Parameters:
    ///   - color: an image color.
    ///   - size: an image size.
    /// - Returns: an image, filled with a provided color.
    class func makeImage(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

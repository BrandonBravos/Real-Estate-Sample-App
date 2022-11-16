//
//  HomeFeedViewModel.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/14/22.
//

import Foundation
import UIKit


final class HomeFeedViewModel{
    
    
    var houseListings =  HouseListings(bundle: []){
        didSet{
            self.updateUI!(houseListings)
            self.checkForImages()
        }
    }
    
    var houseListingsImages = [String: UIImage](){
        didSet{
            self.updateUI!(houseListings)
        }
    }

    public var updateUI: ((_ newDataToDiplay: HouseListings )-> Void)?
    
    func fetchHouseData(){
        NetworkManager.shared.getAppetizers{  [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let houseListings):
                    self?.houseListings = houseListings
                   
                case .failure(let error):
                    switch error {
                    case .invalidData:
                       print("fetchHouseData: Invalid Data")

                    case .invalidURL:
                        print("fetchHouseData: Invalid URL")
                        
                    case .invalidResponse:
                        print("fetchHouseData: Invalid Response")
                        
                    case .unableToComplete:
                        print("fetchHouseData: Invalid unableToComplete")
                    }
                }
            }
        }
    }
    
    // check to see if images are saved in cache
    func checkForImages(){
        for house in houseListings.bundle{
            guard let houseID = house.ListingId else { return }
            
            ImageCache.loadFromCache(fromURL: house.Media![0].MediaURL!, completion: { url, uiImage in
                if let image = uiImage{
                    self.houseListingsImages[houseID] = image
                } else{
                    self.load(fromURL: url, propertyID: houseID)
                }
            })
        }
    }
    
    // load images from website
    func load(fromURL url: String, propertyID: String) {
        NetworkManager.shared.downloadImage(from: url) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.houseListingsImages[propertyID] = uiImage
                ImageCache.storeImage(urlString: url, image: uiImage)
            }
        }
    }

    
}

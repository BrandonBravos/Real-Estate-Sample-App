//
//  NetworkManager.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import Foundation
import UIKit

 class NetworkManager {
    
     static let shared = NetworkManager()
     let baseURL = "https://api.bridgedataoutput.com/api/v2/test/listings?"
     let accessToken = "access_token=6baca547742c6f96a6ff71b138424f21"
     
     private let cache = NSCache<NSString, UIImage>()

     
     func getAppetizers(completed: @escaping (Result<HouseListings, APError>) -> Void) {
         let zillowApiTestString = baseURL + accessToken

         guard let url = URL(string: zillowApiTestString) else {
             completed(.failure(.invalidURL))
             return
         }
                
         let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
             
             if let _ =  error {
                 completed(.failure(.unableToComplete))
                 return
             }
                         
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                 completed(.failure(.invalidResponse))
                 return
             }
             
             guard let data = data else {
                 completed(.failure(.invalidData))
                 return
             }
             
             do {
                 let decoder = JSONDecoder()
                 let decodedResponse = try decoder.decode(HouseListings.self, from: data)
                 completed(.success(decodedResponse))
                 print(decodedResponse.bundle.count)
             } catch {
                 completed(.failure(.invalidData))
             }
         }
         
         task.resume()
     }
     
     
     func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
         
         let cacheKey = NSString(string: urlString)
         
         if let image = cache.object(forKey: cacheKey) {
             completed(image)
             return
         }
         
         guard let url = URL(string: urlString) else {
             completed(nil)
             return
         }
         
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data, let image = UIImage(data: data) else {
                 completed(nil)
                 return
             }
             
             self.cache.setObject(image, forKey: cacheKey)
             completed(image)
         }
         
         task.resume()
     }
     
     
}

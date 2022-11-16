//
//  ImageCache.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/15/22.
//

import Foundation
import UIKit

class ImageCache{
    
    /// stores and caches image into a temporary folder
    static func storeImage(urlString: String, image: UIImage){
        
        // save image to a temporary folder
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        let data = image.pngData()
        try? data?.write(to: url)
        
        //  try to retrieve our cache, if nill create one
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        
        // save our data with our temporary folder path
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
    
    /// attempts to return  uiImage by checking a temporary file path. will return a nil image if not saved
    static func loadFromCache(fromURL url: String, completion: @escaping (String, UIImage?) -> Void) {
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]{
            if let path = dict[url]{
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    let img = UIImage(data: data)
                    completion(url, img)
                    return
                }
            }
        }
        completion(url, nil)
    }
    
  
}

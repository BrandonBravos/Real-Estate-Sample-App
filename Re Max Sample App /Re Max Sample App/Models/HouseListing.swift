//
//  HouseListing.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import Foundation

struct HouseListings: Decodable{
  var bundle: [HouseObject]
}

struct HouseObject: Decodable{
    let City: String?
    let ListingId: String?
    let TaxAssessedValue: Int?
    let LivingArea: Int?
    let CountyOrParish: String?
    let Longitude: Float?
    let Latitude: Float?
    let BedroomsTotal: Int?
    let MainLevelBathrooms: Int?
    let StateOrProvince: String?
    let PostalCode: String?
    let Media: [HouseMedia]?
}


struct HouseMedia: Decodable{
    let MediaURL: String?
    let MediaObjectID: String?
    let Order: Int?
    let ShortDescription: String?
}



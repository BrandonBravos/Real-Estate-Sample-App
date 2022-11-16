//
//  HomeFeedCell.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import UIKit

class HomeFeedCell: UICollectionViewCell {
    
    static let reuseIdentifier = "HomeFeedCellID"
    
    private var homeImageView: UIImageView!
    private var priceLabel: UILabel!
    private var locationLabel: UILabel!
    private var detailsLabel: UILabel!
    private var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func configure(withHouse house: HouseObject){
        if let value = house.TaxAssessedValue {
            priceLabel.text = "$\(value)"
        } else { priceLabel.text = "Error" }
        
        if let county = house.StateOrProvince {
            locationLabel.text = county
        } else { locationLabel.text = "Error" }
            
   
      
        detailsLabel.text = "\(house.BedroomsTotal!) bedroom / \(house.MainLevelBathrooms!) bathroom / \(house.LivingArea!) square ft"
        
    }
    
    func setImage(image: UIImage?){
        if image == nil { return }
        
        homeImageView.image = image
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}






// MARK: Layout
extension HomeFeedCell{
    
    private func setUpView(){
   
        homeImageView = UIImageView()
        homeImageView.layer.cornerRadius = 20
        homeImageView.clipsToBounds = true
        self.addSubview(homeImageView)
        homeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeImageView.topAnchor.constraint(equalTo: topAnchor),
            homeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            homeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            homeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
         
        let favoriteButton = StylizedButton(withImageNamed: "heart_icon")
        favoriteButton.layer.borderWidth = 0
        favoriteButton.backgroundColor = .systemPink
        favoriteButton.backgroundColor = .white
        favoriteButton.buttonImageView?.tintColor = .black
         self.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: homeImageView.topAnchor, constant: 15),
            favoriteButton.trailingAnchor.constraint(equalTo: homeImageView.trailingAnchor, constant: -15),
            favoriteButton.heightAnchor.constraint(equalToConstant: 42),
            favoriteButton.widthAnchor.constraint(equalToConstant: 42)

         ])
          
    

        priceLabel = UILabel()
        priceLabel.text = "$200,000"
        priceLabel.sizeToFit()
        priceLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 22)
        self.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: homeImageView.bottomAnchor, constant: 17),
            priceLabel.leadingAnchor.constraint(equalTo: homeImageView.leadingAnchor)
        ])
        
    
    

         locationLabel = UILabel()
        locationLabel.text = "3155 RockWood Dr, SF"
        locationLabel.textColor = .lightGray
        locationLabel.sizeToFit()
        locationLabel.font = UIFont.montserratFont(withMontserrat: .regular, withSize: 14)
        self.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5)
        ])
        
         detailsLabel = UILabel()
        detailsLabel.text = "3 bedroom / 2 bathroom / 1260ft"
        detailsLabel.sizeToFit()
        detailsLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 15)
        self.addSubview(detailsLabel)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            detailsLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 5)
        ])
    
    
 
        
        
    }
}

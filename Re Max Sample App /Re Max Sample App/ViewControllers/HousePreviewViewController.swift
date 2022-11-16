//
//  SecondViewController.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import UIKit

class HousePreviewViewController: UIViewController, Coordinating {
    var coordinatinor: Coordinator?
    
    var houseObject: HouseObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @objc func returnToHomeFeedView(){
          coordinatinor?.eventOccured(with: .homeViewController)
       }
}




//MARK: Layout
extension HousePreviewViewController{
    
    func setUpView(){
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height * 1.2)
        scrollView.bounces = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "house_default_image")
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -45),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
            
        ])
        
        let backButton = StylizedButton(withImageNamed: "back_icon")
        scrollView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .white
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 45),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 45),
            backButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        backButton.addTarget(self, action: #selector(returnToHomeFeedView), for: .touchDown)
        
        let favortiteButton = StylizedButton(withImageNamed: "heart_icon")
        scrollView.addSubview(favortiteButton)
        favortiteButton.translatesAutoresizingMaskIntoConstraints = false
        favortiteButton.tintColor = .white
        favortiteButton.layer.borderColor = UIColor.white.cgColor
        favortiteButton.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            favortiteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 45),
            favortiteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            favortiteButton.widthAnchor.constraint(equalToConstant: 45),
            favortiteButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        
        let priceLabel = UILabel()
        priceLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 30)
        priceLabel.text = "$\(houseObject!.TaxAssessedValue!)"
        priceLabel.sizeToFit()
        scrollView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),

        ])
        
        
        let addressLabel = UILabel()
        addressLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 12)
        addressLabel.text = " \(houseObject!.City!),  \(houseObject!.StateOrProvince!)  "
        addressLabel.textColor = .darkGray
        addressLabel.sizeToFit()
        scrollView.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0),
            addressLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 5),
        ])
        
        let houseInformationLabel = UILabel()
        houseInformationLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 15)
        houseInformationLabel.text = "House Information"
        houseInformationLabel.sizeToFit()
        scrollView.addSubview(houseInformationLabel)
        houseInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            houseInformationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 35),
            houseInformationLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),

        ])
        
        let postDate = StylizedButton(withLabel: "30+ days ago", style: .bold, size: 15)
        postDate.isUserInteractionEnabled = false
        scrollView.addSubview(postDate)
        postDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postDate.centerYAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            postDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            postDate.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20),
            postDate.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        let infoScrollView = UIScrollView()
        infoScrollView.showsHorizontalScrollIndicator = false
        infoScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 1.2, height: 90)
        scrollView.addSubview(infoScrollView)
        infoScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoScrollView.topAnchor.constraint(equalTo: houseInformationLabel.bottomAnchor, constant: 10),
            infoScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            infoScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            infoScrollView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        let infoTypes = ["Square Feet", "Bedrooms", "Bathrooms", "Walk Score"]
        var leadingConstraint: NSLayoutXAxisAnchor?
        
        for info in infoTypes{
            
            if leadingConstraint == nil {
                leadingConstraint = infoScrollView.leadingAnchor
            }
            
            let infoView = StylizedButton(withLabel: "1260", style: .bold, size: 18)
            infoView.isUserInteractionEnabled = false
            infoScrollView.addSubview(infoView)
            infoView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                infoView.leadingAnchor.constraint(equalTo: leadingConstraint!, constant: 30),
                infoView.centerYAnchor.constraint(equalTo: infoScrollView.centerYAnchor, constant: -10),
                infoView.widthAnchor.constraint(equalTo: infoScrollView.heightAnchor, multiplier: 0.85),
                infoView.heightAnchor.constraint(equalTo: infoScrollView.heightAnchor, multiplier: 0.7),
            ])
            
            let infoLabel = UILabel()
            infoLabel.text = info
            infoLabel.sizeToFit()
            infoLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 12)
            infoScrollView.addSubview(infoLabel)
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                infoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
                infoLabel.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 5)
            ])
            
            leadingConstraint = infoView.trailingAnchor
        }
        
        
        let informationLabel = UILabel()
        informationLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 15)
        informationLabel.textColor = .systemGray
        informationLabel.numberOfLines = 20
        informationLabel.text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            """
        
        informationLabel.sizeToFit()
        scrollView.addSubview(informationLabel)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: infoScrollView.bottomAnchor, constant: 25),
            informationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            
        ])
        
    }
}

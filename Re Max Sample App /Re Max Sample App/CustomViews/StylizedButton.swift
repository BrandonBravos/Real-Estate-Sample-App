//
//  StylizedButton.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import Foundation
import UIKit


// a styleized button used around the app. Has two modes: image and a label
class StylizedButton: UIButton{
    
    var buttonImageView: UIImageView!
    var titleLbl: UILabel!
    
    init(withImageNamed imageName: String) {
        super.init(frame: .zero)
        buttonImageView = UIImageView()
        addButtonImage(imageName)
         addStyle()
    }
    
    init(withLabel title: String, style: UIFont.MontserratType, size: CGFloat) {
        super.init(frame: .zero)
        addCustomTitle(title: title, style: style, size: size)
        addStyle()
    }
    
 
    
    func addButtonImage(_ image: String){
        
        guard let buttonImage = UIImage(named: image) else {
                self.backgroundColor = .red
                return
        }
        buttonImageView.image = buttonImage
        
        self.addSubview(buttonImageView)
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            buttonImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65)

        ])
        
    }
    
    func addCustomTitle( title: String, style: UIFont.MontserratType, size: CGFloat){
        titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = UIFont.montserratFont(withMontserrat: style, withSize: size)
        titleLbl.sizeToFit()
        titleLbl.textAlignment = .center
        self.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLbl.heightAnchor.constraint(equalTo: heightAnchor),
            titleLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
        
    }
    func addStyle(){
        
        self.layer.cornerRadius = 17
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.lightGray.cgColor /* #f7f8fd */

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}

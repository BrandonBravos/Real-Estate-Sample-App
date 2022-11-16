//
//  ViewController.swift
//  Re Max Sample App
//
//  Created by Brandon Bravos on 11/13/22.
//

import UIKit

class HomeFeedViewController: UIViewController, Coordinating {
    
    // reference to our coordinator to switch views
    var coordinatinor: Coordinator?
    
    // collection view that holds our catagories.
    private var homeFeedCollectionView: UICollectionView!
    
    // refence to our view model
    private var viewModel: HomeFeedViewModel!
    
    // how far to slide the menu on open
    private let menuSlidingConstant: CGFloat = 250

    // a reference to our menu view trailing anchor, used for animating open and closing of menu
    private var menuViewTrailingAnchor: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        viewModel = HomeFeedViewModel()

        // set our view models update ui functionality.
        viewModel.updateUI = { [weak self] newData in
            self?.homeFeedCollectionView.reloadData()
        }
        
    }
    
  
    
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchHouseData()
    }
    
    
    @objc private func menuButtonTapped(){
        let isOpen = menuViewTrailingAnchor.constant > 0 ? true : false
        menuViewTrailingAnchor.constant = isOpen ? 0 : menuSlidingConstant
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func pushPreviewController(withIndexPath indexPath: Int){
            let cord = coordinatinor as? MainCoordinator
            cord?.pushHousePreviewController(property: viewModel.houseListings.bundle[indexPath])
       }

    
    


}


// MARK: Delegates

extension HomeFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel.houseListings.bundle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height / 3.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedCell.reuseIdentifier, for: indexPath) as! HomeFeedCell
        let listing = viewModel.houseListings.bundle[indexPath.row]
        cell.configure(withHouse: listing)
        cell.setImage(image: viewModel.houseListingsImages[listing.ListingId!])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushPreviewController(withIndexPath: indexPath.row)
    }
    
    
}









// MARK: Layout
extension HomeFeedViewController{
    
    private func setUpView(){
        self.view.backgroundColor = .white
        
        
        let menuView = MenuView()
        self.view.addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.topAnchor),
            menuView.widthAnchor.constraint(equalToConstant: menuSlidingConstant),
            menuView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    
        menuViewTrailingAnchor = menuView.trailingAnchor.constraint(equalTo: view.leadingAnchor)
        menuViewTrailingAnchor.isActive = true
    
    
        let menuButton = StylizedButton(withImageNamed: "menu_icon")
        self.view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            menuButton.leadingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 25),
            menuButton.widthAnchor.constraint(equalToConstant: 45),
            menuButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchDown)
    
        
        let filterButton = StylizedButton(withImageNamed: "filter_icon")
        self.view.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            filterButton.trailingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: (UIScreen.main.bounds.width-25)),
            filterButton.widthAnchor.constraint(equalToConstant: 45),
            filterButton.heightAnchor.constraint(equalToConstant: 45)
        ])

        
        let searchSubTitleLabel = UILabel()
        searchSubTitleLabel.text = "City"
        searchSubTitleLabel.textColor = .lightGray
        searchSubTitleLabel.sizeToFit()
        self.view.addSubview(searchSubTitleLabel)
        searchSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchSubTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 45 + 40),
            searchSubTitleLabel.leadingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 25),
        ])
        
        let searchHeaderLabel = UILabel()
        searchHeaderLabel.text = "San Francisco"
        searchHeaderLabel.font = UIFont.boldSystemFont(ofSize: 35)

        searchHeaderLabel.sizeToFit()
        searchHeaderLabel.adjustsFontSizeToFitWidth = true
        searchHeaderLabel.minimumScaleFactor = 0.2
        searchHeaderLabel.numberOfLines = 0
        self.view.addSubview(searchHeaderLabel)
        searchHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchHeaderLabel.topAnchor.constraint(equalTo: searchSubTitleLabel.bottomAnchor, constant: 10),
            searchHeaderLabel.leadingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 25),
        ])
        
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        self.view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: searchHeaderLabel.bottomAnchor, constant: 5),
            divider.leadingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 20),
            divider.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        homeFeedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        homeFeedCollectionView.delegate = self
        homeFeedCollectionView.dataSource = self
        
        view.addSubview(homeFeedCollectionView)
        homeFeedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeFeedCollectionView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 10),
            homeFeedCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeFeedCollectionView.leadingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 5),
            homeFeedCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -5),

        ])
        

        homeFeedCollectionView.register(HomeFeedCell.self, forCellWithReuseIdentifier: HomeFeedCell.reuseIdentifier)
  
    }

    

    
}





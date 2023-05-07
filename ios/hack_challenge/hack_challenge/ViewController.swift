//
//  ViewController.swift
//  hack_challenge
//
//  Created by Angela YUAN on 2023/4/29.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    var currentIndex = IndexPath()
    
    //filters array
    private var filters = ["Central", "West", "North"]
    private var booleans = [false, false, false]
    
    // filter buttons
    let centralButton = UIButton()
    let westButton = UIButton()
    let northButton = UIButton()
    
    let refreshControl = UIRefreshControl()
    
    //sections array
    private var sections = ["Central", "West", "North"]
    private var locations: [[Location]] = []
    
    var allSections : [String] = []
    var allLocations : [[Location]] = []
    
    var central : [Location] = []
    var west : [Location] = []
    var north : [Location] = []
    
    
    //paddings
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    
    
    
    //reuseIDs
    let cellReuseID = "cellReuseID"
    let headerReuseID = "headerReuseID"
    let filterCellReuseID = "filterReuseID"
  
    let collectionViewTag = 0
    let filterCollectionViewTag = 1
    
    let userButton = UIButton()
    let sleepButton = UIButton()
    
   

    override func viewDidLoad() {
        
        navigationItem.hidesBackButton = true
        
        var url = URL(string: "http://35.199.32.240:8000/")!
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url.append(queryItems: [formatParameter])
        
        super.viewDidLoad()
        title = "NapApp"
        view.backgroundColor = UIColor(named: "blue")
        
        allLocations = locations
        allSections = sections
        
        centralButton.setTitle("Central", for: .normal)
        centralButton.backgroundColor = .white
        centralButton.setTitleColor(.black, for: .normal)
        centralButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        centralButton.translatesAutoresizingMaskIntoConstraints = false
        centralButton.layer.cornerRadius = 0
        centralButton.tag = 0
        centralButton.addTarget(self, action: #selector(filterLocations), for: .touchUpInside)
        view.addSubview(centralButton)
        
        westButton.setTitle("West", for: .normal)
        westButton.backgroundColor = .white
        westButton.setTitleColor(.black, for: .normal)
        westButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        westButton.translatesAutoresizingMaskIntoConstraints = false
        westButton.layer.cornerRadius = 0
        westButton.tag = 1
        westButton.addTarget(self, action: #selector(filterLocations), for: .touchUpInside)
        view.addSubview(westButton)
        
        northButton.setTitle("North", for: .normal)
        northButton.backgroundColor = .white
        northButton.setTitleColor(.black, for: .normal)
        northButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        northButton.translatesAutoresizingMaskIntoConstraints = false
        northButton.layer.cornerRadius = 0
        northButton.tag = 2
        northButton.addTarget(self, action: #selector(filterLocations), for: .touchUpInside)
        view.addSubview(northButton)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        
        
        //collectionview
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "lightgray")
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        
        
        collectionView.register(CustomCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseID)
        
        collectionView.tag = collectionViewTag
//        filterCollectionView.tag = filterCollectionViewTag
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        userButton.setImage(UIImage(named: "userimg"), for: .normal)
        userButton.backgroundColor =  .white
        userButton.translatesAutoresizingMaskIntoConstraints = false
        userButton.layer.cornerRadius = 0
        userButton.imageView?.contentMode = .scaleAspectFit
        userButton.addTarget(self, action: #selector(profilePush), for: .touchUpInside)
        view.addSubview(userButton)
        
        sleepButton.setImage(UIImage(named: "sleepimg"), for: .normal)
        sleepButton.backgroundColor = .white
        sleepButton.translatesAutoresizingMaskIntoConstraints = false
        sleepButton.layer.cornerRadius = 0
        sleepButton.imageView?.contentMode = .scaleAspectFit
//        sleepButton.addTarget(self, action: #selector(profilePush), for: .touchUpInside)
        view.addSubview(sleepButton)
        
        setupConstraints()
        createDummyData()
    }
    
    
    @objc func filterLocations(sender: UIButton) {
        locations = []
        sections = []
        
        booleans[sender.tag].toggle()
        sender.isSelected.toggle()
        
        if (sender.isSelected){
            sender.layer.borderWidth = 1.0
            sender.layer.borderColor = UIColor.blue.cgColor
//            sender.backgroundColor = .opaqueSeparator
        }
        else{
//            sender.backgroundColor = .white
            sender.layer.borderWidth = 0.0
            sender.layer.borderColor = nil
        }
        
        if (booleans[0]) {
            locations = locations + [allLocations[0]]
            sections = sections + [allSections[0]]
        }
        
        if (booleans[1]) {
            locations = locations + [allLocations[1]]
            sections = sections + [allSections[1]]
        }
        
        if (booleans[2]) {
            locations = locations + [allLocations[2]]
            sections = sections + [allSections[2]]
        }
        
        if (booleans == [true, true, true] || booleans == [false, false, false]){
            locations = allLocations
            sections = allSections
        }
        
        collectionView.reloadData()
    }


    func setupConstraints() {
//        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            centralButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            centralButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centralButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1/3),
            centralButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45)
        ])
        NSLayoutConstraint.activate([
            westButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            westButton.leadingAnchor.constraint(equalTo: centralButton.trailingAnchor),
            westButton.trailingAnchor.constraint(equalTo: northButton.leadingAnchor),
            westButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45)
        ])
        NSLayoutConstraint.activate([
            northButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            northButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            northButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            northButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45)
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: centralButton.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: userButton.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            userButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            userButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            userButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        NSLayoutConstraint.activate([
            sleepButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sleepButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            sleepButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sleepButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    func createDummyData() {
        self.locations = [[],[],[]]
        self.allLocations = [[],[],[]]
        self.sections = ["Central", "West", "North"]
        self.allSections = ["Central", "West", "North"]
        NetworkManager.shared.getLocationSpecific(region: "central") { locations in
            DispatchQueue.main.async {
                self.locations[0] = locations
                self.allLocations[0] = locations
                self.central = locations
                self.collectionView.reloadData()
            }
        }
        
        NetworkManager.shared.getLocationSpecific(region: "north") { locations in
            DispatchQueue.main.async {
                self.locations[2] = locations
                self.allLocations[2] = locations
                self.north = locations
                self.collectionView.reloadData()
            }
        }
        
        NetworkManager.shared.getLocationSpecific(region: "west") { locations in
            DispatchQueue.main.async {
                self.locations[1] = locations
                self.allLocations[1] = locations
                self.west = locations
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func refreshData() {
        self.allLocations = [[],[],[]]
        self.locations = []
        self.allSections = ["Central", "West", "North"]
        self.sections = []
            
        NetworkManager.shared.getLocationSpecific(region: "central") { locations in
            DispatchQueue.main.async {
                self.allLocations[0] = locations
                self.central = locations
                self.reorganizeData()
                self.collectionView.reloadData()
            }
        }
        
        NetworkManager.shared.getLocationSpecific(region: "north") { locations in
            DispatchQueue.main.async {
                self.allLocations[2] = locations
                self.north = locations
                self.reorganizeData()
                self.collectionView.reloadData()
            }
        }
        
        NetworkManager.shared.getLocationSpecific(region: "west") { locations in
            DispatchQueue.main.async {
                self.allLocations[1] = locations
                self.west = locations
                self.reorganizeData()
                self.collectionView.reloadData()
            }
        }
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
        }
    
    
    @objc func reorganizeData() {
        self.locations = []
        if (self.booleans[0] || self.booleans == [false, false, false]) {
            self.locations = self.locations + [central]
            self.sections = self.sections + [allSections[0]]
        }
        
        if (self.booleans[1] || self.booleans == [false, false, false]) {
            self.locations = self.locations + [west]
            self.sections = self.sections + [allSections[1]]
        }
        
        if (self.booleans[2] || self.booleans == [false, false, false]) {
            self.locations = self.locations + [north]
            self.sections = self.sections + [allSections[2]]
        }
    }
    
    @objc func profilePush() {
        let lvc = LoginViewController()
        navigationController?.pushViewController(lvc, animated: true)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.tag == collectionViewTag) {
            return locations[section].count
        }
        
        else{
            return filters.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.tag == collectionViewTag) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? CustomCollectionViewCell {
                let location = locations[indexPath.section][indexPath.item]
                cell.update(location: location)
                return cell
            }
        }
//            else {
//                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseID, for: indexPath) as? CustomFilterCollectionViewCell {
//                    let filter = filters[indexPath.row]
//                    let boolean = booleans[indexPath.row]
//                    cell.configure(filterName: filter, clicked: boolean)
//                    return cell
//                }
//        }
        return UICollectionViewCell()
        
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView.tag == collectionViewTag) {
            return locations.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (collectionView.tag == collectionViewTag) {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseID, for: indexPath) as? CustomCollectionViewHeader {
                header.configure(section: sections[indexPath.section])
                return header
            }
        }
        else {
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if (collectionView.tag == filterCollectionViewTag) {
//            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseID, for: indexPath) as? CustomFilterCollectionViewCell {
//                reorder(val: indexPath.item)
//                //toggle boolean value
//                booleans[indexPath.item].toggle()
//                //reload()
//                collectionView.reloadData()
//            }
//        }
        if (collectionView.tag == collectionViewTag) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? CustomCollectionViewCell{
                //how do I get Resturant instead of [Resturant]?
                let currentLoc = locations[indexPath.section][indexPath.item]
                let vc = DetailViewController(location: currentLoc, section: indexPath.section, index: indexPath.item)
                vc.del = self
                navigationController?.pushViewController(vc, animated: true)
            }
        }
            
        
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.tag == collectionViewTag) {
            let len = (view.frame.width - 2 * itemPadding - sectionPadding - 30) / 2
            return CGSize(width: len*2, height: len)
        }
        else {
            let width = (view.frame.width / 5 )
            return CGSize(width: width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (collectionView.tag == collectionViewTag) {
            return CGSize(width: self.view.frame.width, height: 50)
        }
            return CGSize(width: 0, height: 0)
    }
    
    
}

extension ViewController: updateCell{
    func updateAvailability(index: Int, section: Int, availability: Bool) {
//        locations[section][index].occupied = availability
        if availability {
            NetworkManager.shared.updateOccupacy(id: locations[section][index].id, user_id: 0) {_ in
                DispatchQueue.main.async {
                    self.refreshData()
                }
            }
        }
        else {
            NetworkManager.shared.updateOccupacy(id: locations[section][index].id, user_id: 1) {_ in
                DispatchQueue.main.async {
                    self.refreshData()
                }
            }
        }
    }
    
    
}

//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/26/22.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private var barButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.image = UIImage(systemName: "plus")
        button.target = HabitsViewController.self
        button.action = #selector(didTapButton)
        return button
    }()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 18, right: 17)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let barButtonItem = UIBarButtonItem(image: barButtonItem.image, style: .plain, target: self, action: #selector(didTapButton))
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(
        self.reloadHabits(notification:)), name: Notification.Name("reloadHabits"),
        object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(
        self.reloadProgress(notification:)), name: Notification.Name("reloadProgress"),
        object: nil)
        
        setup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setup() {
        view.backgroundColor = .white
        self.view.addSubview(self.topSeparator)
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            
            self.topSeparator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            self.collectionView.topAnchor.constraint(equalTo: self.topSeparator.bottomAnchor, constant: 22),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    @objc func reloadHabits(notification: Notification) {
        HabitsStore.shared.save()
        self.collectionView.reloadData()
    }
    
    @objc func didTapButton() {
        let vc = HabitViewController()
        let nc = UINavigationController(rootViewController:vc)
//        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true, completion: nil)
    }
}


extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(HabitsStore.shared.habits)
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProgressCollectionViewCell",
                for: indexPath) as! ProgressCollectionViewCell
            print(indexPath)
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "HabitCollectionViewCell",
                    for: indexPath) as! HabitCollectionViewCell
            print(indexPath)
            
            let post = HabitsStore.shared.habits[indexPath.row]
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            cell.setupCell(name: post.name, date: post.dateString, color: post.color)
            cell.habitColorButton.tag = indexPath.row
            return cell
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let width = collectionView.frame.width - insets.left - insets.right
        let itemWidth = floor(width)
        
        if indexPath.section == 0 {
            let itemSize = CGSize(width: itemWidth, height: 60)
            return itemSize
        } else {
            let itemSize = CGSize(width: itemWidth, height: 130)
            return itemSize
        }
    }
}




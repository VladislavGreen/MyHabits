//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Vladislav Green on 9/26/22.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private var barRightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.image = UIImage(systemName: "plus")
        button.target = HabitsViewController.self
        button.action = #selector(didTapAddButton)
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
        
        let barRightButtonItem = UIBarButtonItem(
            image: barRightButtonItem.image,
            style: .plain,
            target: self,
            action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = barRightButtonItem
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(
            self.reloadHabits(notification:)), name: Notification.Name("reloadHabits"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(
            self.showHabitDetais(notification:)), name: Notification.Name("showHabitDetails"),
                                               object: nil)
        setup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setup() {
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        
        self.collectionView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        self.view.addSubview(self.topSeparator)
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.topSeparator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.topSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            self.collectionView.topAnchor.constraint(equalTo: self.topSeparator.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    @objc func reloadHabits(notification: Notification) {
        self.collectionView.reloadData()
    }
    
    @objc func showHabitDetais(notification: Notification) {
        let tag = notification.userInfo![0] as? Int
        let vc = HabitDetailsViewController()
        vc.habitTag = tag!
        
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @objc func didTapAddButton() {
        let vc = HabitViewController()
        vc.habitIsNew = true
        let nc = UINavigationController(rootViewController:vc)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 17)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 18, right: 17)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("Привычек зарегистрировано: \(HabitsStore.shared.habits.count)")
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ProgressCollectionViewCell",
                for: indexPath) as! ProgressCollectionViewCell
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            cell.progressLabel.text = "\(lroundf(HabitsStore.shared.todayProgress*100))%"
            cell.progressBar.progress = HabitsStore.shared.todayProgress
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "HabitCollectionViewCell",
                    for: indexPath) as! HabitCollectionViewCell
            
            let post = HabitsStore.shared.habits[indexPath.row]
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            cell.setupHabitCell(
                name: post.name,
                date: post.dateString,
                color: post.color,
                counter: post.trackDates.count,
                isDoneToday: post.isAlreadyTakenToday
            )
            cell.habitColorButton.tag = indexPath.row
            cell.habitNameLabel.tag = indexPath.row
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




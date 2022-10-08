//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Vladislav Green on 10/5/22.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habitTag = Int()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.29).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var habitHeaderView = UIView()
    
    private lazy var habitHeader: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = myHabitsFonts.footNOTE
        titleLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        titleLabel.attributedText = NSMutableAttributedString(
            string: "АКТИВНОСТЬ",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.sectionHeaderHeight = 46.6
        tableView.rowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(
            self.reloadHabits(notification:)), name: Notification.Name("reloadHabits"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = HabitsStore.shared.habits[habitTag].name
        
        let editButton: UIBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(editHabit))
        self.navigationItem.rightBarButtonItem = editButton;
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.tableView)
        self.habitHeaderView.addSubview(self.habitHeader)
        self.tableView.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            
            self.habitHeader.bottomAnchor.constraint(equalTo: self.habitHeaderView.bottomAnchor, constant: -6.5),
            self.habitHeader.leadingAnchor.constraint(equalTo: self.habitHeaderView.leadingAnchor, constant: 16),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    @objc private func editHabit () {
        let vc = HabitViewController()
        vc.habitIsNew = false
        vc.habitToEditTag = habitTag
        vc.setHabit(habitTag)
        let nc = UINavigationController(rootViewController:vc)
        self.present(nc, animated: true, completion: nil)
    }
    
    @objc private func reloadHabits(notification: Notification) {
//        print("Method reloadHabits activated")
//        self.tableView.reloadData()
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension HabitDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let startDate = HabitsStore.shared.dates[0]
        let diffComponents = Calendar.current.dateComponents([.day], from: startDate, to: Date())
        let daysPassed = diffComponents.day!
        let numberOfSections = daysPassed + 1
//        print(numberOfSections)
        return numberOfSections
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellID", for: indexPath)
        
        cell.textLabel?.text = HabitsStore.shared.dates[indexPath.row].formatted(date: .complete, time: .complete)
        
        if HabitsStore.shared.habit(
            HabitsStore.shared.habits[habitTag],
            isTrackedIn: HabitsStore.shared.dates[indexPath.row]
        ) == true {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = UIImage(systemName: "checkmark")
            cell.accessoryView = imageView
        }
        return cell
    }
}


extension HabitDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return habitHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 47
    }
}

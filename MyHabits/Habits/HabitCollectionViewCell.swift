//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Vladislav Green on 10/2/22.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private lazy var habitCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 216, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = myHabitsFonts.headline
        label.textAlignment = .left
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.attributedText = NSMutableAttributedString(
            string: "Название привычки!",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.isUserInteractionEnabled = true
        let tapHabitName = UITapGestureRecognizer(target: self, action: #selector(didTapHabitName))
        label.addGestureRecognizer(tapHabitName)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitTimeComment: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 95, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        label.font = myHabitsFonts.caption
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.textAlignment = .right
        label.attributedText = NSMutableAttributedString(
            string: "Каждый день в 00:00",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 188, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.attributedText = NSMutableAttributedString(
            string: "Счётчик: 0",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var habitColorButton: UIButton = {
        let button = UIButton()
        let size:CGFloat = 38.0
        let image = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: size, height: size)
        button.layer.cornerRadius = size / 2
        button.layer.borderColor = UIColor(red: 1, green: 0.624, blue: 0.31, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapColorButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.habitCellView)
        self.habitCellView.addSubview(self.habitNameLabel)
        self.habitCellView.addSubview(self.habitTimeComment)
        self.habitCellView.addSubview(self.counterLabel)
        self.habitCellView.addSubview(self.habitColorButton)
        
        NSLayoutConstraint.activate([
            self.habitCellView.topAnchor.constraint(equalTo: self.topAnchor),
            self.habitCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.habitCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.habitCellView.bottomAnchor.constraint(equalTo: self.counterLabel.bottomAnchor, constant: 20),
            
            self.habitNameLabel.topAnchor.constraint(equalTo: self.habitCellView.topAnchor, constant: 20),
            self.habitNameLabel.leadingAnchor.constraint(equalTo: self.habitCellView.leadingAnchor, constant: 20),
            
            self.habitTimeComment.topAnchor.constraint(equalTo: self.habitNameLabel.bottomAnchor, constant: 4),
            self.habitTimeComment.leadingAnchor.constraint(equalTo: self.habitCellView.leadingAnchor, constant: 20),

            self.counterLabel.topAnchor.constraint(equalTo: self.habitTimeComment.bottomAnchor,constant: 30),
            self.counterLabel.leadingAnchor.constraint(equalTo: self.habitCellView.leadingAnchor, constant: 20),
            
            self.habitColorButton.centerYAnchor.constraint(equalTo: habitCellView.centerYAnchor),
            self.habitColorButton.widthAnchor.constraint(equalToConstant: 38),
            self.habitColorButton.heightAnchor.constraint(equalToConstant: 38),
            self.habitColorButton.trailingAnchor.constraint(equalTo: self.habitCellView.trailingAnchor, constant: -25)
        ])
    }
    
    func setupHabitCell(name: String, date: String, color: UIColor, counter: Int, isDoneToday: Bool ) {
        self.habitNameLabel.text = name
        self.habitNameLabel.textColor = color
        self.habitTimeComment.text = date
        self.habitColorButton.layer.borderColor = color.cgColor
        
        let counterValue = counter
        self.counterLabel.text = "Счётчик \(counterValue)"
        
        let habitIsDoneToday = isDoneToday
        self.habitColorButton.layer.backgroundColor = habitIsDoneToday == true
            ? habitColorButton.layer.borderColor
            : UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
    }
    
    @objc private func didTapColorButton() {
       
        if HabitsStore.shared.habits[habitColorButton.tag].isAlreadyTakenToday == false {
            
            NotificationCenter.default.post(name: Notification.Name("reloadHabits"), object: nil)
            HabitsStore.shared.track(HabitsStore.shared.habits[habitColorButton.tag])
            print("👻 Поздравления!\(HabitsStore.shared.habits[habitColorButton.tag]))")
        } else {
            print ("Сегодня уже было такое")
        }
    }
    
    @objc private func didTapHabitName() {
        NotificationCenter.default.post(name: Notification.Name("showHabitDetails"), object: nil, userInfo: [0 : habitNameLabel.tag])
    }
}

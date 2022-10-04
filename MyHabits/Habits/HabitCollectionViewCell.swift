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
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var habitNameLabel: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 216, height: 18)
//        label.clipsToBounds = true
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = myHabitsFonts.headline
        label.textAlignment = .left
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.attributedText = NSMutableAttributedString(
            string: "Название привычки!",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitTimeComment: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 95, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        label.font = myHabitsFonts.caption
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.textAlignment = .right
        label.attributedText = NSMutableAttributedString(
            string: "Каждый день в 00:00",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterValue = Int()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 188, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
                label.attributedText = NSMutableAttributedString(
            string: "Счётчик: \(counterValue)",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var habitColorButton: UIButton = {
        let button = UIButton()
        let size:CGFloat = 38.0
        let image = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        button.setImage(image, for: .normal)
//        button.tag = 0
        
        button.frame = CGRect(x: 0, y: 0, width: size, height: size)
        button.layer.cornerRadius = size / 2
        button.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
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
    
    func setupCell(name: String, date: String, color: UIColor ) {
        self.habitNameLabel.text = name
        self.habitTimeComment.text = date
        self.habitColorButton.layer.borderColor = color.cgColor
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
    
    @objc func didTapColorButton() {
        print("It works")
        
        
        // Найти экземпляр класса Habit, который использовался для формирование этой ячейки
        // Покрасить кнопку в его цвет
        
        habitColorButton.backgroundColor = HabitsStore.shared.habits[habitColorButton.tag].color
        
        
        // Сравнить дату с isAlreadyTakenToday (её значение calendar.isDateInToday(lastTrackDate)) и если false =>
        // Сохранить время в Habit.trackDates используя HabitsStore.shared.track()
        // Увеличить показания счётчика на 1,
        // (если true, то пока просто пишем в консоль)
        
        if HabitsStore.shared.habits[habitColorButton.tag].isAlreadyTakenToday == false {
            HabitsStore.shared.track(HabitsStore.shared.habits[habitColorButton.tag])
            counterValue += 1
            counterLabel.text = "Счётчик: \(counterValue)"
        } else {
            print ("Сегодня уже было такое")
        }
        
                
        // Отобразить пересчитанный прогресс (обновить CollectionView ??? )
        // Вот эта штука перепутывает все кнопки и не работает всё равно:
//        NotificationCenter.default.post(name: Notification.Name("reloadHabits"), object: nil)
        
        
        
        // Cохраняем изменения
        // Не работает? Или мы не загружает изменения при перезагрузке?
//        HabitsStore.shared.save()
        
        
        // Дефолтный цвет не сохраняется для привычки, если его не менять при создании привычки
        // Не обновляется прогресс сразу после изменений
        // Не запоминаются состояния кнопок и счётчика при перезагрузке, при этом прогресс загружается правильно
    }
}

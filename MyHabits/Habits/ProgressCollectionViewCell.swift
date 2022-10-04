//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Vladislav Green on 10/2/22.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var progressCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressBarLabel: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 216, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = myHabitsFonts.footnoteStatus
        label.textAlignment = .right
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.attributedText = NSMutableAttributedString(
            string: "Всё получится!",
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var todayProgress = HabitsStore.shared.todayProgress
    var todayProgresPercantage = "\(HabitsStore.shared.todayProgress*100)"
    
    private lazy var progressLabel: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 95, height: 18)
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = myHabitsFonts.footnoteStatus
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        label.textAlignment = .right
//        let todayProgress = HabitsStore.shared.todayProgress
//        let todayProgresPercantage = "\(HabitsStore.shared.todayProgress*100)"
        label.attributedText = NSMutableAttributedString(
            string: todayProgresPercantage,
            attributes: [NSAttributedString.Key.kern: -0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progressViewStyle = .bar
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 5
        bar.setProgress(todayProgress, animated: true)
        bar.trackTintColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
        bar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.addSubview(self.progressCellView)
        self.progressCellView.addSubview(self.progressBarLabel)
        self.progressCellView.addSubview(self.progressLabel)
        self.progressCellView.addSubview(self.progressBar)
        
        NSLayoutConstraint.activate([
            self.progressCellView.topAnchor.constraint(equalTo: self.topAnchor),
            self.progressCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.progressCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.progressCellView.bottomAnchor.constraint(equalTo: self.progressBar.bottomAnchor, constant: 15),
            
            self.progressBarLabel.topAnchor.constraint(equalTo: self.progressCellView.topAnchor, constant: 10),
            self.progressBarLabel.heightAnchor.constraint(equalToConstant: 18),
            self.progressBarLabel.leadingAnchor.constraint(equalTo: self.progressCellView.leadingAnchor, constant: 12),
            
            self.progressLabel.topAnchor.constraint(equalTo: self.progressCellView.topAnchor, constant: 10),
            self.progressLabel.trailingAnchor.constraint(equalTo: self.progressCellView.trailingAnchor, constant: -12),
            self.progressLabel.heightAnchor.constraint(equalToConstant: 18),

            self.progressBar.topAnchor.constraint(equalTo: self.progressBarLabel.bottomAnchor,constant: 10),
            self.progressBar.leadingAnchor.constraint(equalTo: self.progressCellView.leadingAnchor, constant: 12),
            self.progressBar.trailingAnchor.constraint(equalTo: self.progressCellView.trailingAnchor, constant: -12),
            self.progressBar.heightAnchor.constraint(equalToConstant: 7),
        ])
    }
}

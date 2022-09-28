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
//        button.target = HabitsViewController.self
        button.action = #selector(didTapButton(sender:))
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
    }
    
    @objc func didTapButton(sender: UIBarButtonItem) {
        
    }
}


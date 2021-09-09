//
//  ViewController.swift
//  GCD
//
//  Created by Юлия Караневская on 8.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    let button: UIButton = {
        let b = UIButton()
        b.backgroundColor = .systemPink
        b.addTarget(self, action: #selector(toTheSecondVC), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setButton()
    }
    
    @objc private func toTheSecondVC() {
        let vc = SecondViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    private func setButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }


}


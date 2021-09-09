//
//  SecondViewController.swift
//  GCD
//
//  Created by Юлия Караневская on 8.09.21.
//

import UIKit

class SecondViewController: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.style = .large
        ai.color = .systemRed
        return ai
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemPink
        return iv
    }()
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            activityIndicator.isHidden = true
        }
    }
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        fetchImage()
        delay(3) {
            self.showAlert()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupImageView()
        setupActivityIndicator()
    }
    
    private func delay(_ dalay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(dalay)) {
            closure()
        }
    }
    
    private func fetchImage() {
        url = URL(string: "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/large_jpg/02C.jpg?1590547607")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let url = url else { return }
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Login", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        alert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        present(alert, animated: true, completion: nil)
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

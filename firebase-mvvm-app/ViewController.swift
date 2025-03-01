//
//  ViewController.swift
//
//
//  Created by Seigetsu on 2024/03/26
//
//

import UIKit
import FirebaseGoogleAuthUI
import SnapKit

class ViewController: UIViewController {
    private let authUI: FUIAuth = {
        let authUI = FUIAuth.defaultAuthUI()!
        authUI.providers = [
            FUIGoogleAuth(authUI: authUI)
        ]
        return authUI
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("認証画面を開く", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ViewController"
        view.backgroundColor = .systemBackground
        
        authUI.delegate = self
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension ViewController: FUIAuthDelegate {
    nonisolated func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, url: URL?, error: (any Error)?) {
        if let error {
            print("error: \(error)")
        } else {
            print("success: \(authDataResult?.user.uid.description ?? "nil")")
        }
    }
}

#Preview {
    ViewController()
}

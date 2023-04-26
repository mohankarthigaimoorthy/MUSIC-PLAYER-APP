//
//  popUP.swift
//  musicPlayer
//
//  Created by Mohan K on 07/01/23.
//

import Foundation

import UIKit


class popUP: UIViewController {
    

    @IBOutlet weak var back1View: UIView!
    
    @IBOutlet weak var content1View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    init() {
        super.init(nibName: "popUP", bundle: nil)
        self.modalPresentationStyle = .overFullScreen    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
   

func configView() {
    self.view.backgroundColor = .clear
    self.back1View.backgroundColor = .black.withAlphaComponent(0.6)
    self.back1View.alpha = 0
    self.content1View.alpha = 0
    self.content1View.layer.cornerRadius = 10
}

func appear(sender: UIViewController) {
    sender.present(self, animated: false) {
        self.show()
    }
}

private func show() {
    UIView.animate(withDuration: 1, delay: 0.1) {
        self.back1View.alpha = 1
        self.content1View.alpha = 1
    }
}

func hide() {
    UIView.animate(withDuration: -1, delay: 0.0, options: .curveEaseOut) {
        self.back1View.alpha = 0
        self.content1View.alpha = 0
    } completion: { _ in
        self.dismiss(animated: false)
        self.removeFromParent()
    
    }
}

}

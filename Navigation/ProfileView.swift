//
//  ProfileView.swift
//  Navigation
//
//  Created by Lev on 17.03.2022.
//

import Foundation
import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var userInfo: UIStackView!
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var userText: UITextView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    private func setupView() {
        let view = self.loadViewFromXib()
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? UIView else { return UIView() }
        return view
    }
    
}

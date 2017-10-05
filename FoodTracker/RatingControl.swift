//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Tommy on 9/15/17.
//  Copyright © 2017 Tommy. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //    MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
            updateButtonSelectionState()
        }
    }
    @IBInspectable var startSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var startCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    
    //    MARK: initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //    MARK: Button Actions
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("the \(button) is not in \(ratingButtons)")
        }
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        }else{
            rating = selectedRating
        }
    }
    
    //    MARK:Private method
    private func setupButtons()  {
        //        Clear any exist button
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //        Load Button Images
        let bundle = Bundle(for:type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highLightStar = UIImage(named: "highLightStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<startCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highLightStar, for: .highlighted)
            button.setImage(highLightStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: startSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: startSize.width).isActive = true
            //          Setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //          Add button to stack
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }
    
    private func updateButtonSelectionState(){
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}

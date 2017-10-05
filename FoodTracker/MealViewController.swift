//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Tommy on 9/14/17.
//  Copyright © 2017 Tommy. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate {
    
    //    MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        //        Set up views if editing an existing Meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
//            Test content mode image
            photoImageView.contentMode = .scaleAspectFit
            ratingControl.rating = meal.rating
        }
        //        enable the save button only if the text field has valid name
        updateSaveButtonState()
    }
    //    MARK: UITextFiledDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    //    MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //        dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("expexted an image but was provided following \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    //    MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //        Depend on style of presentation(modal or push presentation) this view needs to dismiss in different way
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The MealViewControler is not inside a navigation controller.")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("not save btn press", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    //    MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //        Hide the keyboard
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //    MARK: Private Methods
    func updateSaveButtonState() {
        //        Disabled save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}


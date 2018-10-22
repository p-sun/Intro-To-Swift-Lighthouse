//
//  FirstViewController.swift
//  Pizza
//
//  Created by Curtis Mak on 2017-11-18.
//  Copyright © 2017 Curtis Mak. All rights reserved.
//

import UIKit
import Parse

class AddFoodViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBOutlet var loadingView: UIActivityIndicatorView!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
	@IBOutlet weak var priceTextField: UITextField!
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var submitButton: UIButton!
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadingView.isHidden = true
        
        self.nameTextField.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        self.nameTextField.placeholder = "Food Name"
        
        self.descriptionTextField.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        self.descriptionTextField.placeholder = "Food Description"
        
        self.foodImageView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        self.foodImageView.isUserInteractionEnabled = true
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddFoodViewController.imageTapped))
        self.foodImageView.addGestureRecognizer(self.tapGesture)
        
        self.submitButton.backgroundColor = UIColor.orange
        self.submitButton.setTitleColor(UIColor.white, for: .normal)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.addTarget(self, action: #selector(AddFoodViewController.submitAction), for: .touchUpInside)
        
        // Test Parse Server First!
        
//        let myPizzaObject = PFObject(className: "Food")
//        myPizzaObject["name"] = "Pizza"
//        myPizzaObject["description"] = "Pizza is cheesy!"
//        myPizzaObject.saveInBackground()
        
    }
    
    @objc func submitAction(){
        
        /*
         First iteration:
         
         - Create a new PFObject for Food with name and description
         - Save PFObject
         - Show alert we are done
         - Clear textfields
         
         // https://medium.com/ios-os-x-development/introduction-to-closures-in-swift-3-1d46dfaf8a20
         */
        
//        let foodObj = PFObject(className: "Food")
//        foodObj["name"] = self.nameTextField.text!
//        foodObj["description"] = self.descriptionTextField.text!
//        foodObj.saveInBackground { (success, error) in
//
//            self.nameTextField.text = ""
//            self.descriptionTextField.text = ""
//        }
        
        
        /*
         Second iteration:
         
         - Save PFFile with image data
         - Wait until saved
         - Create new PFObject with name/description/image
         - Save PFObject
         - Show alert we are done
         - Clear textfields
         */
		
		
		saveFood()
		// saveArmor()
    }
	
	func saveFood() {
		// Step 1) Save Food image
		let imageData = UIImageJPEGRepresentation(self.foodImageView.image!, 0.9)
		let pfFile = PFFile(data: imageData!)
		pfFile?.saveInBackground(block: { (success, error) in
			
			// Step 2) Create food object
			let foodObj = PFObject(className: "Food")
			foodObj["name"] = self.nameTextField.text!
			foodObj["description"] = self.descriptionTextField.text!
			foodObj["price"] = self.priceTextField.text!
			
			// Step 3) Link image to food objedct
			foodObj["image"] = pfFile
			
			// Step 4) Save Food object,
			foodObj.saveInBackground { (success, error) in
				
				self.nameTextField.text = ""
				self.descriptionTextField.text = ""
				self.priceTextField.text = ""
				
				// Dismissing keyboard
				self.view.endEditing(true)
			}
		})
	}
	
	func saveArmor() {
		let armor = Armor()
		armor.displayName = "Great Medieval Armor"
		armor.needsRepair = true
		armor.material = ["plastic", "ivory", "chainmail"]
		
		
		let pizza = Pizza()
		pizza.pizzaName = "Medieval Deluxe"
		
		armor.pizza = pizza
		armor.saveInBackground { (success, error) in
			
			print("***** success: \(success), error: \(error)")
			
		}
	}
	
    @objc func imageTapped(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.foodImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

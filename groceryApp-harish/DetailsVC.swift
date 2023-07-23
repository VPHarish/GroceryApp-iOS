//
//  DetailsVC.swift
//  groceryApp-harish
//
//  Created by Harish on 22/07/23.
//

import UIKit

class DetailsVC: UIViewController {

    var product: MainScreenVC.shoppingItem!
    
    
    @IBOutlet weak var imageUrl: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var units: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productName.text = "Product: " + product.Name
        imageUrl.image = UIImage(named: product.imageName)
        unitPrice.text = "Price : " + product.unitPrice
        units.text = "Units : " + product.units
        quantity.text = "Quantity : " + String(product.Quantity)
    }
}

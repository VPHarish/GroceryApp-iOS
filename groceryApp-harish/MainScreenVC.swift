//
//  MainScreenVC.swift
//  groceryApp-harish
//
//  Created by Harish on 22/07/23.
//

import UIKit

class MainScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var categorySelector: UISegmentedControl!
    
    
    struct shoppingItem {
        let Name: String
        let imageName: String
        let unitPrice: String
        let units: String
        let itemDescription: String
        let Quantity: Int
    }
    
    let shoppingItems:[shoppingItem] = [
        shoppingItem(Name: "Cookies", imageName: "Cookies", unitPrice: "$2.95", units: "13.3 oz",        itemDescription: "Chocolate", Quantity: 3),
        shoppingItem(Name: "Black Berries", imageName: "Blackberries", unitPrice: "$3.95", units: "1", itemDescription: "Organic", Quantity: 2),
        shoppingItem(Name: "Apples", imageName: "Apple", unitPrice: "$1.99", units: "", itemDescription: "Organic", Quantity: 1),
        shoppingItem(Name: "Blue Berries", imageName: "Blueberries", unitPrice: "$4.95", units: "3", itemDescription: "Organic", Quantity: 3),
        shoppingItem(Name: "Steak", imageName: "Steak", unitPrice: "$11.99", units: "1 lb", itemDescription: "Fresh", Quantity: 7),
        shoppingItem(Name: "Bread", imageName: "Bread", unitPrice: "$3.99", units: "1", itemDescription: "Organic", Quantity: 2),
        shoppingItem(Name: "Milky Bar", imageName: "Milkybar", unitPrice: "$2.95", units: "13.3 oz", itemDescription: "Chocolate", Quantity: 4),
        shoppingItem(Name: "Orange Juice", imageName: "Orangejuice", unitPrice: "$5.00", units: "1 L", itemDescription: "Organic", Quantity: 5),
        shoppingItem(Name: "Bananas", imageName: "Banana", unitPrice: "$0.99", units: "1 kg", itemDescription: "Organic", Quantity: 1),
        shoppingItem(Name: "Canteloupe", imageName: "Canteloupe", unitPrice: "$0.63", units: "1 kg", itemDescription: "Organic", Quantity: 3),
        shoppingItem(Name: "Cheerios", imageName: "Cheerios", unitPrice: "$3.13", units: "12 oz", itemDescription: "Gluten Free", Quantity: 4),
        shoppingItem(Name: "Turkey", imageName: "Turkey", unitPrice: "$23.04", units: "16 lb", itemDescription: "Fresh", Quantity: 1),
        shoppingItem(Name: "Dates", imageName: "Dates", unitPrice: "$3.49", units: "1 kg", itemDescription: "Organic", Quantity: 6),
        shoppingItem(Name: "Dragon Fruit", imageName: "Dragonfruit", unitPrice: "$7.34", units: "3 oz", itemDescription: "Organic", Quantity: 1),
        shoppingItem(Name: "Figs", imageName: "Fig", unitPrice: "$4.09", units: "5 oz", itemDescription: "Organic", Quantity: 3),
        shoppingItem(Name: "Ground Chicken", imageName: "GroundChicken", unitPrice: "$7.49", units: "1 lb", itemDescription: "Fresh", Quantity: 2),
        shoppingItem(Name: "Hot Dog Buns", imageName: "Hotdogbun", unitPrice: "$3.49", units: "8 ct", itemDescription: "Enriched Buns", Quantity: 1),
        shoppingItem(Name: "Eggs", imageName: "Eggs", unitPrice: "$7.49", units: "1 dozen", itemDescription: "Organic", Quantity: 4),
        shoppingItem(Name: "Peaches", imageName: "Peach", unitPrice: "$4.99", units: "3 lb", itemDescription: "Organic", Quantity: 7),
        shoppingItem(Name: "Oranges", imageName: "Orange", unitPrice: "$5.49", units: "12 ct", itemDescription: "Organic", Quantity: 1),
        shoppingItem(Name: "Mineral Water", imageName: "Mineralwater", unitPrice: "$5.00", units: "12 ct", itemDescription: "Water", Quantity: 2),
        shoppingItem(Name: "Rice Krispies", imageName: "Rice_krispies", unitPrice: "$3.38", units: "18 oz", itemDescription: "Kelloggs", Quantity: 3)
    ]
    
    var product: shoppingItem!
    
    var grpedCategories:[String] = []
    var grpedShoppingList:[String:[shoppingItem]] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        for p in shoppingItems {
            let i = p.itemDescription
            if !grpedCategories.contains(i) {
                grpedCategories.append(i)
                grpedShoppingList[i] = []
            }
        }
        grpedCategories.sort()
        
        for p in shoppingItems {
            let i = p.itemDescription
            grpedShoppingList[i]?.append(p)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var select:Int = 1
        switch categorySelector.selectedSegmentIndex {
        case 1:
            select = grpedCategories.count
        default:
            select = 1
        }
        return select
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (categorySelector.selectedSegmentIndex == 0) {
            return shoppingItems.count
        } else {
            return grpedShoppingList[grpedCategories[section]]?.count ?? 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view: UIView
        switch categorySelector.selectedSegmentIndex {
        case 1:
            view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
         view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            let lbl = UILabel(frame: CGRect(x: 5, y: 0, width: view.frame.width - 50, height: 30))
            lbl.font = UIFont.systemFont(ofSize: 20)
            lbl.text = grpedCategories[section]
            view.addSubview(lbl)
        default:
            view = UIView(frame: CGRect(x: 1, y: 0, width: tableView.frame.width, height: 1))
        }
        return view
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (categorySelector.selectedSegmentIndex == 1) {
            product = grpedShoppingList[grpedCategories[indexPath.section]]?[indexPath.row]
            let cell = table.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableVCell
            cell.productName.text = product.Name
            cell.imageUrl.image = UIImage(named: product.imageName)
            cell.productPrice.text = product.unitPrice
            return cell
        } else {
        product = shoppingItems[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableVCell
        cell.productName.text = product.Name
        cell.imageUrl.image = UIImage(named: product.imageName)
        cell.productPrice.text = product.unitPrice
        return cell
            }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailShowSegue") {
            let detailVC = segue.destination as! DetailsVC
            detailVC.product = product
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (categorySelector.selectedSegmentIndex == 1) {
            product = grpedShoppingList[grpedCategories[indexPath.section]]?[indexPath.row]
        } else {
        product = shoppingItems[indexPath.row]
            }
        self.performSegue(withIdentifier: "detailShowSegue", sender: nil)
    }
    
    
    @IBAction func categorySelector(_ sender: UISegmentedControl) {
        table.reloadData()
    }
    
    
    
    
    
    
    
// Old code for uncategorised version.
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return shoppingItems.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        product = shoppingItems[indexPath.row]
//        let cell = table.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableVCell
//        cell.productName.text = product.Name
//        cell.imageUrl.image = UIImage(named: product.imageName)
//        cell.productPrice.text = product.unitPrice
//        return cell
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "detailShowSegue") {
//            let detailVC = segue.destination as! DetailsVC
//            detailVC.product = product
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        product = shoppingItems[indexPath.row]
//        self.performSegue(withIdentifier: "detailShowSegue", sender: nil)
//    }
    
}

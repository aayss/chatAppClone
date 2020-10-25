//
//  ViewController.swift
//  messangerapp
//
//  Created by Ays  on 25.10.2020.
//  Copyright © 2020 AyseCengiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchEditText: UITextField!
    
    //define variables
    var screenWidth:CGFloat = 0
    
    var dataArsiv = Array<(id:String, userName:String, message:String, date:String, searchID: Bool, imageUrl:String, receiver:String, receiverImage:String)>()
    
    var dataArsivSearch = Array<(id:String, userName:String, message:String, date:String, searchID: Bool, imageUrl:String, receiver:String, receiverImage:String)>()
    
    var dateString: String = ""
    var indexNo : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //After typing search edit text, make the keyboard dissmis
        hideKeyboardWhenTappedAround()
        
        //take the screen size for responsive design
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        
        //listening to the text for the search
        searchEditText.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
    
        addButton.layer.cornerRadius = 25
        
        // get users
        getData()
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        //I am looking for every letter entered in user name.
        //I make the searchID value true and show it in the list.
        let search_text : String = textField.text!
        if(textField.text!.count > 0)
        {
            for i in 0 ..< self.dataArsivSearch.count
            {
                if dataArsivSearch[i].userName.localizedLowercase.contains(search_text.localizedLowercase)
                   || dataArsivSearch[i].userName.localizedUppercase.contains(search_text.localizedUppercase)
                {
                    dataArsivSearch[i].searchID = true
                }
                else
                {
                    dataArsivSearch[i].searchID = false
                }
            }
            
            dataArsiv.removeAll()
            
            for i in 0 ..< self.dataArsivSearch.count
            {
                if dataArsivSearch[i].searchID
                {
                    dataArsiv.append(dataArsivSearch[i])
                }
            }
              self.collectionView.reloadData()
        }
        else
        {
            getData()
        }
      
    }
    
    //I am using the prepare method to send data to another page.
    //In this way, I list which user_name is clicked.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ConversationController
        {
            let vc = segue.destination as? ConversationController
            vc?.id = self.dataArsiv[indexNo].id
            vc?.user_name = self.dataArsiv[indexNo].userName
            vc?.image_name = self.dataArsiv[indexNo].imageUrl
            vc?.receiver_id = self.dataArsiv[indexNo].receiver
            vc?.receiver_image = self.dataArsiv[indexNo].receiverImage
        }
    }
    
    //number of item in collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataArsiv.count
    }
    
    //I give the value of every object in the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MainCELL", for: indexPath) as! MainCell
        
        cell.layer.cornerRadius = 10
        
        cell.userName.text = self.dataArsiv[indexPath.row].userName
        cell.message.text = self.dataArsiv[indexPath.row].message
        cell.date.text = "\(self.dataArsiv[indexPath.row].date)"
        cell.image.image = UIImage(named: self.dataArsiv[indexPath.row].imageUrl)
        
        return cell
    }
    
    //When the cell is selected, I send it to the new page.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.indexNo = indexPath.row
        performSegue(withIdentifier: "mainToConversationSegue", sender: nil)
        
    }
    
    //I adjust the width and height of the cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.screenWidth - 10
        let height = CGFloat(80)
        return CGSize(width: width, height: height)
        
    }
    
    

    func getData()
    {
       // producing fake data
        self.dataArsiv.append((id: "3OnvLxIzkBND0Jr3aMtp", userName: "Project Manager", message: "And yourself? ", date: "21.10.2020", searchID: false, imageUrl: "four", receiver: "FP8kTAjftLLeGgAjJzUR", receiverImage: "three"))
        self.dataArsiv.append((id: "FP8kTAjftLLeGgAjJzUR", userName: "Frontend Developer", message: "I’m well.", date: "21.10.2020", searchID: false, imageUrl: "three", receiver: "3OnvLxIzkBND0Jr3aMtp", receiverImage: "four"))
        self.dataArsiv.append((id: "YLKMmveb7LiH5YgI86Jv", userName: "Project Manager", message: "bye bye! :)", date: "24.10.2020", searchID: false, imageUrl: "six", receiver: "GovXYKl8P57QUxTummB7", receiverImage: "one"))
               self.dataArsiv.append((id: "FP8kTAjftLLeGgAjJzUR", userName: "Frontend Developer", message: "Bye! Have a good day!", date: "24.10.2020", searchID: false, imageUrl: "one", receiver: "GovXYKl8P57QUxTummB7", receiverImage: "six"))
    }
    
}

//this extension is for keyboard dissmis
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


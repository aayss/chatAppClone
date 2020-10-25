//
//  ConversationController.swift
//  messangerapp
//
//  Created by Ays  on 25.10.2020.
//  Copyright © 2020 AyseCengiz. All rights reserved.
//

import UIKit

class ConversationController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageEdit: UITextField!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var nameText: UILabel!
    
    //define variables
    var screenWidth:CGFloat = 0
    
    var id : String = ""
    var receiver_id : String = ""
    var user_name : String = ""
    var image_name : String = ""
    var receiver_image : String = ""
    var input_message : String = ""
    var dateString: String = ""
    
    var dataArsiv = Array<(from:String, to:String, message:String, date:String)>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //After typing search edit text, make the keyboard close
        hideKeyboardWhenTappedAround()
        
        //take the screen size for responsive design
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        
        nameText.text = user_name
        
        // get messages
        getMessages()
        
        
    }
    
    //this action make page close when back press
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //add the message to the database
    @IBAction func sendAction(_ sender: Any) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        
        self.input_message = messageEdit.text!
        
        self.dataArsiv.append((from: id, to: receiver_id, message: self.input_message, date: result))
        self.messageEdit.text = ""
        self.collectionView.reloadData()
        let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
        let lastItemIndex = NSIndexPath(item: item, section: 0)
        self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: .bottom, animated: false)
    }
    
    
    //number of item in collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataArsiv.count
    }
    
    //I give the value of every object in the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ConversationCELL", for: indexPath) as! ConversationCell
        
        //I am adding pictures of who are speaking.
        //I make the conversation appear to the right and left side
        if self.dataArsiv[indexPath.row].from.elementsEqual(self.id)
        {
            cell.secondImage.image = UIImage(named: image_name)
            
            cell.firstImage.isHidden = true
            cell.secondImage.isHidden = false
            
            
            cell.chatView.frame = CGRect(x: 150, y: 40, width: screenWidth-150, height: 50)
            cell.chatView.backgroundColor =  UIColor.init(red: 152.0/255.0, green: 163.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            cell.date.textAlignment = .right
        }
        else
        {
            cell.firstImage.image = UIImage(named: receiver_image)
            
            cell.secondImage.isHidden = true
            cell.firstImage.isHidden = false
            
            cell.date.textAlignment = .left
            
            cell.chatView.frame = CGRect(x: 0, y: 40, width: screenWidth-150, height: 50)
            cell.chatView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 192.0/255.0, blue: 217.0/255.0, alpha: 1.0) //.init(red: 255.0, green: 192.0, blue: 217.0, alpha: 1.0)
        }
        
        cell.messages.frame = CGRect(x: 5, y: 5, width: screenWidth-150, height: 40)
        cell.messages.text = self.dataArsiv[indexPath.row].message
        cell.date.text = "\(self.dataArsiv[indexPath.row].date)"
        
        cell.layer.cornerRadius = 10
        cell.chatView.layer.cornerRadius = 3
        //        cell.firstImage.layer.cornerRadius = 17
        
        
        return cell
    }
    
    
    //I adjust the width and height of the cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = self.screenWidth - 20
        let height = CGFloat(112)
        return CGSize(width: width, height: height)
        
    }
    
    
    func getMessages()
    {
        self.dataArsiv.removeAll()
        // producing fake data
       
        
        self.dataArsiv.append((from: id, to: receiver_id, message: "Hello", date: "22/10/2020"))
        self.dataArsiv.append((from: receiver_id, to: id, message: "Hi, how are you?", date: "22/10(2020"))
        
        self.dataArsiv.append((from: id, to: receiver_id, message: "Fine and you?", date: "23/10/2020"))
        
        self.dataArsiv.append((from:receiver_id, to: id, message: "I'm well, Thank you", date: "24/10/2020"))
        
        let item = self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1
        let lastItemIndex = NSIndexPath(item: item, section: 0)
        self.collectionView?.scrollToItem(at: lastItemIndex as IndexPath, at: .bottom, animated: false)
    }
    
    
}

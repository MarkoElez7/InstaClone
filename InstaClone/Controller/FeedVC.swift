//
//  FeedVC.swift
//  InstaClone
//
//  Created by Marko  on 8/17/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var postButton: RoundedButton!
    @IBOutlet weak var imageAdd: CircleImageView!
    
    var imageSelected = false
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        print("XYZ: user from keychain \(KeychainWrapper.standard.string(forKey: KEY_UID))")
        print("XYZ: user from firebase \(Auth.auth().currentUser?.uid)")
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        self.feedTableView.register(FeedCell.self)
                
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                var posts = [Post]()
                for snap in snapshot {
                    print(snap)
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        posts.append(post)
                    }
                }
                self.posts = posts.reversed()
            }
            self.feedTableView.reloadData()
        }
        
    }
    
    @IBAction func signoutPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
        print("signed out successfully")
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("XYZ: No caption")
            return
        }
        guard let img = imageAdd.image, imageSelected == true else {
            print("XYZ: No image")
            return
        }
        if let imageData = UIImageJPEGRepresentation(img, 0.2) {
            let imageUID = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let postImagesRef = DataService.ds.REF_POST_IMAGES.child(imageUID)
            postImagesRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("XYZ: failed while uploading image to firebase")
                } else {
                    print("XYZ: successfully uploaded image to firebase")
                    postImagesRef.downloadURL(completion: { (url, error) in
                        guard let downloadURL = url else {
                            print("error getting download url")
                            return
                        }
                        self.postToFirebase(imgURL: downloadURL.absoluteString)
                    })
                }
            }
        }
        
    }
    
    func postToFirebase(imgURL: String) {

        
        DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? Dictionary<String, Any> {
                if let username = data["username"] as? String {
                    print("XYZ: username = \(username)")
                    
                    let post: Dictionary<String, Any> = [
                        "caption": self.captionField.text!,
                        "imageURL": imgURL,
                        "username": username,
                        "likes": 0
                    ]
                    DataService.ds.REF_POSTS.childByAutoId().setValue(post)
                    self.captionField.text = ""
                    self.imageSelected = false
                    self.imageAdd.image = UIImage(named: "smiley")
                    self.feedTableView.reloadData()
                } else {
                    print("XYZ: unable to get username")
                }
            } else {
                print("XYZ: unable to get data")
            }
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCell = tableView.dequeueReusableCell(for: indexPath)
        let post = posts[indexPath.row]
                
        if let img = FeedVC.imageCache.object(forKey: post.imageURL as NSString) {
            cell.configureCell(post: post, img: img)
        } else {
            cell.configureCell(post: post)
        }
        return cell
    }
}

extension FeedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true
        } else {
            print("XYZ: Invalid Image")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}

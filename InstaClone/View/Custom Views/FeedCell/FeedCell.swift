//
//  FeedCell.swift
//  InstaClone
//
//  Created by Marko  on 8/17/18.
//  Copyright © 2018 markoelez. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var likesImage: CircleImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLabel: UILabel!
    
    var post: Post!
    var likesRef: DatabaseReference!

    override func awakeFromNib() {
        super.awakeFromNib()
        print("XYZ: tapped")

        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped(sender: UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value) { (snapshot) in
            print("XYZ: tapped")
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "like")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likesImage.image = UIImage(named: "like-2")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
                
            }
        }
    }

    func configureCell(post: Post, img: UIImage?=nil) {
     
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = String(post.likes)
        self.usernameLabel.text = post.username
        
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        
        if img != nil {
            self.postImage.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageURL)
            ref.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
                if error != nil {
                    print("XYZ: Unable to download image")
                } else {
                    print("XYZ: Image downloaded")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                    }
                }
            }
        }
        
        likesRef.observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "like-2")
            } else {
                self.likesImage.image = UIImage(named: "like")
            }
        }
    }
}

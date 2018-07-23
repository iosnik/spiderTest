//
//  DetailsViewController.swift
//  SpiderTestApp
//
//  Created by Антон on 19.07.2018.
//  Copyright © 2018 Anton Trofimov. All rights reserved.
//

import UIKit
import ImgurSession
import AlamofireImage

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    weak var image: IMGGalleryImage!
    
    var comments = [String]()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = image.title
        
        commentLabel.text = "Comments:"
        
        let filter = AspectScaledToFillSizeFilter(size: imageView.bounds.size)

        imageView.af_setImage(withURL: image.url, filter: filter)
        
        DispatchQueue.main.async {
            IMGGalleryRequest.comments(withGalleryID: self.image.imageID, with: .new, success: { (comments) in
                let commentsTemp = comments as! [IMGComment]? ?? []
                self.comments = self.convert(comments: commentsTemp)
                self.commentsTableView.reloadData()
            }) { (error) in
                //  error
            }
        }

    }
    
    func convert(comments: [IMGComment]) -> [String] {
        var commentsStr = [String]()
        for c in comments {
            commentsStr.append(c.caption)
        }
        return commentsStr
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.commentLabel.text = self.comments[indexPath.row]
        return cell
    }
}

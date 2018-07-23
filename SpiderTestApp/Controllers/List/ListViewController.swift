//
//  ViewController.swift
//  SpiderTestApp
//
//  Created by Антон on 16.07.2018.
//  Copyright © 2018 Anton Trofimov. All rights reserved.
//

import UIKit
import ImgurSession
import AlamofireImage
import Bond

class ListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = Observable<[IMGGalleryImage]>([])
    
    var page = 0
    
    var loadMoreInProgress = false
    
    var allowLoadMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        loadData()
    }
    
    func configureBindings() {
        
        images.bind(to: collectionView) { (images, indexPath, collectionView) -> UICollectionViewCell in
            
            let image = images[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            
            cell.pictureImageView.image = nil
            
            let filter = AspectScaledToFillSizeFilter(size: cell.pictureImageView.bounds.size)
            
            cell.pictureImageView.af_setImage(withURL: image.url, filter: filter)
            
            cell.titleLabel.text = image.title
            
            cell.image = image
            
            if indexPath.row == max(images.count - 1, 0) && self.allowLoadMore && !self.loadMoreInProgress {
                self.loadMore()
            }
            
            return cell
        }
        
    }
    
    
    func loadInitialData() {
        self.page = 0
        loadData()
    }
    
    func loadMore() {
        self.loadMoreInProgress = true
        loadData(loadingMore: true)
    }
    
    func loadData(loadingMore: Bool = false) {
        IMGGalleryRequest.topGalleryPage(page, with: IMGTopGalleryWindow.all, success: { objects in
            let items = objects?.filter({ $0 is IMGGalleryImage }) as? [IMGGalleryImage] ?? []
            self.allowLoadMore = !items.isEmpty
            self.loadMoreInProgress = false
            if loadingMore {
                self.images.value.append(contentsOf: items)
            } else {
                self.images.value = items
            }
            self.page += 1
        }, failure: presentError)
    }
    
    func presentError(_ error: Error?) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        vc.image = (sender as? ImageCollectionViewCell)?.image
    }
 
}


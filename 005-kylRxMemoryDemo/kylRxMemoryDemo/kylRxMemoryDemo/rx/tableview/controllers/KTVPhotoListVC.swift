//
//  KTVPhotoListVC.swift
//  kylRxMemoryDemo
//
//  Created by yulu kong on 2019/8/24.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import Photos


private let reuseIdentifier = "KTVPhotoListVC"

class KTVPhotoListVC: UIViewController {
    
    fileprivate lazy var photos = KTVPhotoListVC.loadPhotos()
    fileprivate lazy var imageManager = PHCachingImageManager()
    fileprivate lazy var thumbNailSize: CGSize = {
        let cellSize = (self.collevtionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return CGSize(width: cellSize.width * UIScreen.main.scale,
                      height: cellSize.height * UIScreen.main.scale)
    }()
    
    // 使用懒加载集合视图
    lazy var collevtionView : UICollectionView = {
        // 创建UICollectionViewFlowLayout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: (width-40) / 4, height: (width-40) / 4)
        // 创建 UICollectionView
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(LGPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collevtionView)
        self.title = "选择备忘照片"
    }
    
    
    //  MARK: Photo library
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: options)
    }
    
}

// MARK: UICollectionViewDataSource
extension KTVPhotoListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LGPhotoCell
        let asset = photos.object(at: indexPath.item)
        cell.representedAssetIdentifier = asset.localIdentifier
        imageManager.requestImage(for: asset,
                                  targetSize: thumbNailSize,
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler:{ (image, _) in
                                    guard let image = image else { return }
                                    if cell.representedAssetIdentifier == asset.localIdentifier {
                                        cell.imageView.image = image
                                    }
        }
        )
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension KTVPhotoListVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let asset = photos.object(at: indexPath.item)
        if let cell = collectionView.cellForItem(at: indexPath) as? LGPhotoCell {
            cell.selected()
        }
        imageManager.requestImage(for: asset,
                                  targetSize: view.frame.size,
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { _, _ in })
    }
}

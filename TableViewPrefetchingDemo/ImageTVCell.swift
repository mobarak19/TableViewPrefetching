//
//  ImageTVCell.swift
//  TableViewPrefetchingDemo
//
//  Created by Genusys Inc on 6/27/22.
//

import UIKit

class ImageTVCell: UITableViewCell {


    
    private var imageV : UIImageView = {
        let imgV = UIImageView()
        imgV.clipsToBounds = true
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    static let identifire = "ImageTVCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpImageView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpImageView() {
        imageV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageV)
        NSLayoutConstraint.activate([
        
            imageV.widthAnchor.constraint(equalToConstant: 300),
            imageV.heightAnchor.constraint(equalToConstant: 300),
            imageV.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageV.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //imageV.image = nil
    }
    func configure(_ model:ViewModel){
        model.downloadImage {[weak self] image in
            print(image)
            DispatchQueue.main.async {
                self?.imageV.image = image

            }
        }
    }
    

}

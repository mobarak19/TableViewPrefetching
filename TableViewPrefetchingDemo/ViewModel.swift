//
//  ViewModel.swift
//  TableViewPrefetchingDemo
//
//  Created by Genusys Inc on 6/27/22.
//

import Foundation
import UIKit

class ViewModel{
    
    init(){}
    var cashedImage:UIImage?
    func downloadImage(completion:((UIImage?)->Void)?){
        if let image = cashedImage{
            completion?(image)
            return
        }
    
        let size = Int.random(in: 100...350)
        guard let url = URL(string: "https://source.unsplash.com/random/\(size)*\(size)") else {
            print("url")
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            print("response---->.>>>",response)
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.cashedImage = image
                completion?(image)
            }
        }
        task.resume()
    }
}

//
//  ImageManager.swift
//  MiProjectoModular
//
//  Created by Matias Blacutt on 15/11/2021.
//

import Foundation

protocol Image{
    func getImage() -> UIImage?
}

struct ImageAsset: Image{

    let named: String
    
    init(named: String){
        self.named = named
    }
    
    func getImage() -> UIImage? {
        return UIImage(named: self.named)
    }
    
}

struct ImageGif: Image{
    
    let resource: String
    
    init(resource: String){
        self.resource = resource
    }
    
    func getImage() -> UIImage? {
        let possibleUrlImage = Bundle.main.url(forResource: self.resource, withExtension: "gif")
        guard let urlImage = possibleUrlImage else {
            return nil
        }
        return UIImage.animatedImage(withAnimatedGIFURL: urlImage)
    }
}

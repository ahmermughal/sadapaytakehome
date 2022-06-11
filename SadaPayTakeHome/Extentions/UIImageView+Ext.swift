//
//  UIImageView+Ext.swift
//  SadaPayTakeHome
//
//  Created by Ahmer Mughal on 6/11/22.
//

import Foundation
import UIKit

extension UIImageView{
    func downloadImage(fromURL url: String){
           NetworkManager.shared.downloadImage(from: url) { [weak self] image in
               guard let self = self else{return}
               DispatchQueue.main.async {
                   self.image = image
               }
           }
       }
}

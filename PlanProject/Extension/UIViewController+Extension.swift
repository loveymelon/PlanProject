//
//  UIViewController+Extension.swift
//  PlanProject
//
//  Created by 김진수 on 2/19/24.
//

import UIKit

extension UIView {
    func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let directoryURL = documentDirectory.appendingPathComponent("Images")
        
        let fileURL = directoryURL.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
        
    }
    
    func saveImageToDocument(image: UIImage, filename: String) {
    
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let directoryURL = documentDirectory.appendingPathComponent("Images")
        
        let fileURL = directoryURL.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error")
        }
    }
}

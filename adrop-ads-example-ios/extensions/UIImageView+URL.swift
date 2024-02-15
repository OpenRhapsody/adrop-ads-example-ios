//
//  UIImageView+URL.swift
//  adrop-ads-example-ios
//
//  Created by Leo on 2/14/24.
//

import UIKit

func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil, let image = UIImage(data: data) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        DispatchQueue.main.async {
            completion(image)
        }
    }.resume()
}

func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

extension UIImageView {
    func loadImage(from url: URL) {
        let localFilePath = getDocumentsDirectory().appendingPathComponent(url.lastPathComponent)

        if FileManager.default.fileExists(atPath: localFilePath.path) {
            self.image = UIImage(contentsOfFile: localFilePath.path)
            return
        }
        
        downloadImage(from: url) { downloadedImage in
            guard let image = downloadedImage else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            if let data = image.jpegData(compressionQuality: 1) ?? image.pngData() {
                try? data.write(to: localFilePath)
            }
        }
    }
}

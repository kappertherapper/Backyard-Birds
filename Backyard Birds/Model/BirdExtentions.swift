//
//  BirdExtentions.swift
//  Backyard Birds
//
//  Created by Kasper Jonassen on 12/12/2024.
//

import MapKit
import Firebase
import PhotosUI

// Geopoint -> CLLocationCoordinate2D
extension GeoPoint {
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

// CLLocationCoordinate2D -> Geopoint
extension CLLocationCoordinate2D {
    func toGeoPoint() -> GeoPoint {
        return GeoPoint(latitude: self.latitude, longitude: self.longitude)
    }
}

// UIImage -> String
extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 0.5)?.base64EncodedString()
    }
}

// String -> UIImage
extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}

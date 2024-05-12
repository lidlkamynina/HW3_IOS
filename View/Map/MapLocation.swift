import Foundation
import UIKit
import CoreLocation

/*extension ImageModel {
    func readMetadata(fromURL url: URL?) -> NSDictionary? {
        guard let url = url else { return nil }
        
        if let source = CGImageSourceCreateWithURL(url as CFURL, nil),
           let metadata = CGImageSourceCopyMetadataAtIndex(source, 0, nil) as NSDictionary? {
            return metadata
        }
        return nil
    }
    
    func getGpsCoordinates(fromURL url: URL?) -> CLLocationCoordinate2D? {
        if let exif = readMetadata(fromURL: url) {
            if let gpsDic = exif.value(forKey: "{GPS}") as? NSDictionary {
                if let lat = gpsDic.value(forKey: kCGImagePropertyGPSLatitude as String) as? Double,
                   let long = gpsDic.value(forKey: kCGImagePropertyGPSLongitude as String) as? Double {
                    return CLLocationCoordinate2D(latitude: lat, longitude: long)
                }
            }
        }
        
        return nil
    }
    
    struct Exif {
        var dateTaken: String?
        
        init (dateTaken: String? = nil) {
            self.dateTaken = dateTaken
        }
    }
    
    func getExif(fromURL url: URL?) -> Exif? {
        if let exif = readMetadata(fromURL: url) {
            var returnObject = Exif()
            if let exifDic = exif.value(forKey: "{Exif}") as? NSDictionary {
                returnObject.dateTaken = exifDic.value(forKey: kCGImagePropertyExifDateTimeOriginal as String) as? String
            }
            return returnObject
        }
        return nil
    }
} */

final class MapLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var selectedMarkerId: UUID?

    let locations: [MapId] = [
        .init(
            name: "Valmieras Drāmas teātris",
            coordinate: CLLocationCoordinate2D(latitude: 57.5394, longitude: 25.4264)
        ),
        .init(
            name: "Latvijas Nacionālais teātris",
            coordinate: CLLocationCoordinate2D(latitude: 56.9536, longitude: 24.1047)
        ),
        .init(
            name: "Daugavpils teātris",
            coordinate: CLLocationCoordinate2D(latitude: 55.8705, longitude: 26.5172)
        )
    ]

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("\(location.coordinate.latitude) | \(location.coordinate.longitude)")
        userLocation = location.coordinate
    }
}





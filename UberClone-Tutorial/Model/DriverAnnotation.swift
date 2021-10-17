//
//  DriverAnnotation.swift
//  UberClone-Tutorial
//
//  Created by Pipe Carrasco on 16-10-21.
//

import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D){
        self.uid = uid
        self.coordinate = coordinate
    }
}

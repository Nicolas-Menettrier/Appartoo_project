//
//  ViewAllBarController.swift
//  appartoo
//
//  Created by Nicolas Menettrier on 20/06/2016.
//  Copyright © 2016 Nicolas Menettrier. All rights reserved.
//

import MapKit
import UIKit

class ViewAllBarController: UIViewController {
    
    @IBOutlet weak var mapAllBar: MKMapView!
    var donnees: [entree]?
    var zoom = 0.07
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = CLLocationCoordinate2D(latitude: 48.85, longitude: 2.34)
        let span = MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapAllBar.setRegion(region, animated: true)
        if donnees != nil {
            for i in donnees! {
                let annotation = MKPointAnnotation()
                let locate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
                annotation.coordinate = locate
                annotation.title = i.bar_name
                annotation.subtitle = i.bar_tag
                mapAllBar.addAnnotation(annotation)
            }
        }
         // Do any additional setup after loading the view.
    }

    @IBAction func SatelliteMode(sender: AnyObject) {
        if mapAllBar.mapType == MKMapType.Standard {
            mapAllBar.mapType = MKMapType.Satellite
        }
        else {
            mapAllBar.mapType = MKMapType.Standard
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

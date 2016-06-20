//
//  BarViewController.swift
//  Appartoo_bar
//
//  Created by Nicolas Menettrier on 30/05/2016.
//  Copyright © 2016 Nicolas Menettrier. All rights reserved.
//

import UIKit
import MapKit

class BarViewController: UIViewController {
    
    @IBOutlet weak var map_bar_view: MKMapView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var Size: UISlider!
    @IBOutlet weak var Name: UILabel!

    var bar_name: String?
    var bar_tag: String?
    var latitude: Double?
    var longitude: Double?
    var isAnimated = false
    var zoom: Double? = 0.005

    override func viewDidLoad() {
        super.viewDidLoad()
        map_bar_view.hidden = true
        self.Name.text = "\(Size.value)"
        let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        let span = MKCoordinateSpan(latitudeDelta: zoom!, longitudeDelta: zoom!)
        let region = MKCoordinateRegion(center: location, span: span)
        
        map_bar_view.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = bar_name
        annotation.subtitle = bar_tag
        map_bar_view.addAnnotation(annotation)
    }
    
    //à la disparation
    override func viewDidDisappear(animated: Bool) {
        if isAnimated == true {
            UIView.animateWithDuration(1, animations: {
                self.map_bar_view.center.x -= 500
            })
        }
        map_bar_view.hidden = true
        isAnimated = false
    }
    
    //à l'apparition
    override func viewDidAppear(animated: Bool) {
        map_bar_view.hidden = false
        if isAnimated == false {
            UIView.animateWithDuration(1, animations: {
                self.map_bar_view.center.x += 500
            })
            isAnimated = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //mode satellite
    @IBAction func satelliteButton(sender: UIButton) {
        if map_bar_view.mapType == MKMapType.Standard {
            map_bar_view.mapType = MKMapType.Satellite
        }
        else {
            map_bar_view.mapType = MKMapType.Standard
        }
    }

    //zoom fonction
    @IBAction func slider(sender: UISlider) {
        self.Name.text = "\(Size.value)"
        zoom = Double(Size.value / 100)
        let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        let span = MKCoordinateSpan(latitudeDelta: zoom!, longitudeDelta: zoom!)
        let region = MKCoordinateRegion(center: location, span: span)
        
        map_bar_view.setRegion(region, animated: true)
        
    }
    
}

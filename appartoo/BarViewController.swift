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
    var bar_name: String?
    var bar_tag: String?
    var latitude: Double?
    var longitude: Double?
    var zoom: Double? = 0.005
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var Size: UISlider!
    @IBOutlet weak var Name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func satelliteButton(sender: UIButton) {
        if map_bar_view.mapType == MKMapType.Standard {
            map_bar_view.mapType = MKMapType.Satellite
        }
        else {
            map_bar_view.mapType = MKMapType.Standard
        }
    }

    @IBAction func slider(sender: UISlider) {
        self.Name.text = "\(Size.value)"
        zoom = Double(Size.value / 100)
        let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        let span = MKCoordinateSpan(latitudeDelta: zoom!, longitudeDelta: zoom!)
        let region = MKCoordinateRegion(center: location, span: span)
        
        map_bar_view.setRegion(region, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

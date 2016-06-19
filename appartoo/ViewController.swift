//
//  ViewController.swift
//  appartoo
//
//  Created by Nicolas Menettrier on 31/05/2016.
//  Copyright © 2016 Nicolas Menettrier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var donnees = [entree]()
    
    struct entree {
        let image_url :String
        let bar_name :String
        let bar_tag :String
        let bar_address :String
        let latitude :Double
        let longitude : Double
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        extract_json()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return donnees.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cellu", forIndexPath: indexPath) as! BarTableViewCell
         // Configure the cell...
        let entre = donnees[indexPath.row]
        let session = NSURLSession.sharedSession()
        let image_url: NSURL = NSURL(string: entre.image_url)!
        let request: NSURLRequest = NSURLRequest(URL: image_url)
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if error == nil {
                cell.bar_photo.image = UIImage(data: data!)
            }
        }
        cell.bar_name.text = entre.bar_name
        dataTask.resume()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapOfBar" {
            let details = segue.destinationViewController as! BarViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                let entre = donnees[indexPath.row]
                details.latitude = entre.latitude
                details.longitude = entre.longitude
                details.bar_name = entre.bar_name
                details.bar_tag = entre.bar_tag
            }
        }
    }
    
    func extract_json() {
        let path = NSBundle.mainBundle().pathForResource("Pense bete", ofType: "json")
        let json_data = NSData(contentsOfFile: path!)! as NSData
        do {
            let json_bar = try NSJSONSerialization.JSONObjectWithData(json_data, options: NSJSONReadingOptions.MutableContainers)
            if let bar = json_bar["bars"] as? NSArray {
                for i in bar {
                    let image_url = i["image_url"] as? String
                    let bar_name = i["name"] as? String
                    var bar_tag = i["tags"] as? String
                    let address = i["address"] as? String
                    let latitude = i["latitude"] as? Double
                    let longitude = i["longitude"] as? Double
                    if bar_tag == nil {
                        bar_tag = "Pas de tag"
                    }
                    self.donnees += [entree(image_url: image_url!, bar_name: bar_name!, bar_tag: bar_tag!, bar_address: address!, latitude: latitude!, longitude: longitude!)]
                }
            }
        }
        catch {
            print("Error while loading Json")
        }
    }

}




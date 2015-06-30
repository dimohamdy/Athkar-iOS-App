//
//  MainViewController.swift
//  Athkar
//
//  Created by binaryboy on 6/26/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    var menuItems = [MenuItem]()
    var selectedMenuItem: MenuItem!
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        var logoImage: UIImage  = UIImage(named: "iAthkarLogo2")!
        
        self.navigationItem.titleView = UIImageView(image: logoImage)
        
        

        
        backgroundThread(background: {
            // Your function here to run in the background
            
            let path = NSBundle.mainBundle().pathForResource("AthkarMenu", ofType:"plist")
            let dict = NSDictionary(contentsOfFile:path!)!
            let venuesArray : AnyObject = (dict as AnyObject).valueForKey("AthkarMenu")!
            
            
            for dict in venuesArray as! [Dictionary<String,String>]{
                self.menuItems.append(MenuItem(menu: dict))
                
            }
            
            },
            completion: {
                // A function to run in the foreground when the background thread is complete
            self.tableView.reloadData()
        });
        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
            action: "showPresent:")
        screenEdgeRecognizer.edges = .Right
        view.addGestureRecognizer(screenEdgeRecognizer)
        
    }
    func showPresent(sender: UIScreenEdgePanGestureRecognizer) {
        // 1
        if sender.state == .Ended {
            self.performSegueWithIdentifier("PresentViewController", sender: self)
        
        }
    }
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return menuItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        cell.menuNameLabel.text = menuItems[indexPath.item].name
        
        var color:UIColor =   getRandomColor()
        cell.menuNameLabel.textColor = color
        cell.menuColorView.backgroundColor = color

        // Configure the cell...

        return cell
    }

    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("You selected cell #\(indexPath.row)!")
        selectedMenuItem =  menuItems[indexPath.row]
        self.performSegueWithIdentifier("PageViewerViewController", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if "PresentViewController" == segue.identifier{
            
        }else{
        var pageViewerViewController:PageViewerViewController = segue.destinationViewController as! PageViewerViewController
        pageViewerViewController.page = selectedMenuItem.page
        pageViewerViewController.pageTitle = selectedMenuItem.name
        
        }
    }
   
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    

}

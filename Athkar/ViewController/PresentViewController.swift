//
//  PresentViewController.swift
//  Athkar
//
//  Created by binaryboy on 6/28/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController{

    @IBOutlet var currentDaylabel: UILabel!
    @IBOutlet var datelabel: UILabel!
    @IBOutlet var bgImage: UIImageView!
    
    @IBOutlet var athkarLabel: UILabel!
    var athkarItems = [String]()
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let formatter = NSDateFormatter()
        let loc: NSLocale = NSLocale(localeIdentifier: "ar")
        formatter.locale = loc
        
        formatter.dateFormat = "dd MMMM yyyy" // Set the way the date should be displayed
        datelabel.text = formatter.stringFromDate(NSDate())


        formatter.dateFormat = "EEEE"
        let dayOfWeekString = formatter.stringFromDate(NSDate())
        println(dayOfWeekString)
        currentDaylabel.text = dayOfWeekString
        
        
        
        backgroundThread(background: {
            // Your function here to run in the background
            let path = NSBundle.mainBundle().pathForResource("AthkarList2", ofType:"plist")
            let dict = NSDictionary(contentsOfFile:path!)!
            let array : AnyObject = (dict as AnyObject).valueForKey("Mix")!
            
            
            for athkarString in array as! [String]{
                self.athkarItems.append(athkarString)
                
            }
            },
            completion: {
                // A function to run in the foreground when the background thread is complete
                self.getRandom()

        });
        

        
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self,
            action: "dismissController:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        
    }
    func getRandom() {
    
    let randomImageIndex = Int(arc4random_uniform(UInt32(21)))
    var imageName: String = "DarkBG" + "\(randomImageIndex)"
    
    bgImage.image = UIImage(named: imageName)
    
    let randomAthkarIndex = Int(arc4random_uniform(UInt32(92)))

    athkarLabel.text = athkarItems[randomAthkarIndex]
    
    }
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getOther(sender: UITapGestureRecognizer) {
        
        getRandom()
        
    }

    @IBAction func dismissController(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

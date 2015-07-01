//
//  PageViewerViewController.swift
//  Athkar
//
//  Created by binaryboy on 6/26/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class PageViewerViewController: UIViewController ,UIScrollViewDelegate{

    @IBOutlet var fastListTable: UITableView!
    @IBOutlet var contentScrollView: UIScrollView!
    internal var page:String!
    internal var pageTitle:String!
    internal var selectedColor:UIColor!

    @IBOutlet var counterView: UIView!
    var athkarItems = [Athkar]()

    
    @IBOutlet var circleCounter: DMCircleCounter!
    @IBOutlet var progresCount: DMCircleCounterWithOutSegment!
    @IBOutlet var plusOneButton: UIButton!

    var currentCounterValue: Int  = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        contentScrollView.delegate = self
        self.navigationItem.title = pageTitle
        self.navigationController?.navigationBar.barTintColor = selectedColor
        backgroundThread(background: {
            // Your function here to run in the background
            //Page
            let path = NSBundle.mainBundle().pathForResource("AthkarList", ofType:"plist")
            let dict = NSDictionary(contentsOfFile:path!)!
            let array : AnyObject = (dict as AnyObject).valueForKey(self.page)!
            
            
            for dict in array as! [Dictionary<String,String>]{
           self.athkarItems.append(Athkar(athkar: dict))
                
            }
            },
            completion: {
                self.fastListTable.reloadData()
                // A function to run in the foreground when the background thread is complete
                var count = 0
                for athkar in self.athkarItems{
                    var x:CGFloat = self.view.frame.width * CGFloat(count)
                    let webV:UIWebView = UIWebView(frame: CGRectMake(x, 0, self.view.frame.width, self.contentScrollView.frame.height))
                    webV.loadHTMLString(athkar.athkar, baseURL: nil)
                    //            let myHTMLString: String! = "<h1>Hello Pizza!</h1>"
                    //            webV.loadHTMLString(myHTMLString, baseURL: nil)
                    self.contentScrollView.addSubview(webV)
                    webV.scrollView.scrollEnabled = true;
                    webV.scrollView.bounces = false;
                    webV.userInteractionEnabled = false;
                    
                    count++
                }
                self.contentScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(self.athkarItems.count), height: 0)
                self.contentScrollView.pagingEnabled = true
                self.contentScrollView.showsHorizontalScrollIndicator = false;
                self.contentScrollView.showsVerticalScrollIndicator = false;
                self.contentScrollView.bounces = false;

        });

        



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return athkarItems.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PageCell", forIndexPath: indexPath) as! PageCell
        
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor.whiteColor()

        }
        else
        {
            cell.backgroundColor = UIColor(rgba: "#f6f6f6")

        }
        
        //print(athkarItems[indexPath.item].title)
        cell.titleLabel.text = athkarItems[indexPath.item].title
  
        cell.numberLabel.text = "\(indexPath.row+1)"

        
        // Configure the cell...
        
        return cell
    }
    
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //println("You selected cell #\(indexPath.row)!")
//        selectedMenuItem =  menuItems[indexPath.row]
//        self.performSegueWithIdentifier("PageViewerViewController", sender: self)
    }
    @IBAction func showList(sender: AnyObject) {
        
        UIView.transitionWithView(fastListTable, duration: 0.5, options:UIViewAnimationOptions.TransitionCrossDissolve  , animations: { () -> Void in
            if self.fastListTable.hidden{
             self.fastListTable.hidden = false
            }else{
                self.fastListTable.hidden = true

            }
            }, completion: nil);

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
    var  count: Float = 0.0
    var counterForLabel:Int = 0
    
    @IBAction func countPlusOne(sender: AnyObject) {

        var value: Float = 1.0 / Float(currentCounterValue);
        setNumberInButton(++counterForLabel)
        if  count == 1.0 {
            progresCount.resetView();
            count = 0.0;
            counterForLabel = 0;
            setNumberInButton(counterForLabel)
            
        }
        count += value;

        progresCount.countOfSegment(count);

    }
    func setNumberInButton(number: Int ){
        
        var countString: String = "\(number)";
        
        plusOneButton.setTitle(countString, forState: UIControlState.Normal)
        plusOneButton.setTitle(countString, forState: UIControlState.Application)
        plusOneButton.setTitle(countString, forState: UIControlState.Highlighted)
        plusOneButton.setTitle(countString, forState: UIControlState.Reserved)
        plusOneButton.setTitle(countString, forState: UIControlState.Selected)
        plusOneButton.setTitle(countString, forState: UIControlState.Disabled)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        count = 0
        progresCount.resetView()
        circleCounter.resetView()

        counterForLabel = 0
        setNumberInButton(0)

        var page: Int = (Int)(scrollView.contentOffset.x  / scrollView.frame.size.width)
        var athkar: Athkar = athkarItems[page]
        
        currentCounterValue = athkar.count!
        if athkar.count == 0 {
            counterView.hidden = true
            
        }else{
            
            counterView.hidden = false
            circleCounter.countOfSegment(Float(athkar.count!))


        }
        
    }
}

//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Derek Chang on 2/9/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var characterCount: UILabel!
    
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self as? UITextViewDelegate
        tweetTextView.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        characterCount.text = String(140 - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

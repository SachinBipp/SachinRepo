//
//  HomeVC.swift
//  JnJ
//
//  Created by Admin on 20/01/22.
//

import UIKit

class HomeVC: UIViewController, FilterProtocolDelegate {
    

    

    func didReceiveFilterResponsee(filterResponse: [String]) {
            print(filterResponse)
        self.selectedFilterArray = filterResponse
            btnFilter.setImage(UIImage(named: "icon_filter_filled"), for: .normal)
    }
    
    var name1 = String()

     var selectedFilterArray: [String] = ["---","---","---","---","---"]
    @IBOutlet weak var underlineViewDetailBtn: UIView!
    
    @IBOutlet weak var underlineViewOverAllBtn: UIView!
    
    @IBOutlet weak var overAllBtn: UIButton!
    @IBOutlet weak var deailViewBtn: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    
    override func viewDidLoad() {
        btnViewUpdate(btnTypew: 1)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterBtnClicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.delegate = self
        vc.selectedFilterMenu = self.selectedFilterArray
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func detailViewBtnClicked(_ sender: Any) {
         self.btnViewUpdate(btnTypew: 1)
    }

    @IBAction func overAllViewBtnClicked(_ sender: Any) {
        self.btnViewUpdate(btnTypew: 2)
    }

    func btnViewUpdate(btnTypew: Int)
    {
        if(btnTypew == 1)
        {
            self.underlineViewDetailBtn.backgroundColor = .themeColor
            self.underlineViewOverAllBtn.backgroundColor = .clear
            self.deailViewBtn.tintColor = .themeColor
            self.overAllBtn.tintColor = .label
        }
        else if(btnTypew == 2)
        {
            self.underlineViewOverAllBtn.backgroundColor = .themeColor
            self.underlineViewDetailBtn.backgroundColor = .clear
            self.deailViewBtn.tintColor = .label
            self.overAllBtn.tintColor = .themeColor
            self.deailViewBtn.tintColor = .label
        }
    }
    
    
}

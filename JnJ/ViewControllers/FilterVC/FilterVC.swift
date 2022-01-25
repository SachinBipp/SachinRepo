//
//  TestViewController.swift
//  JnJ
//
//  Created by Admin on 21/01/22.
//

import UIKit

protocol FilterProtocolDelegate
{
    func didReceiveFilterResponsee(filterResponse: [String])
        //func testDelegate()
}

class FilterVC: UIViewController {
    
    var delegate: FilterProtocolDelegate?
    
    let filterNameArray  = ["Segment", "Platform", "Cluster", "Site", "Board"]
    var subFiltersArray = ["Jonhnson and Johnson 1", "Jonhnson 2", "Jonhnson 3", "Jonhnson 4", "Jonhnson 5", "Jonhnson 6", "Jonhnson 7", "Jonhnson 8"]
    
    let tempSegmentArray = ["Segment 1", "Segment 2", "Segment 3", "Segment 4"]
    let tempPlatformArray = ["Platform 1", "Platform 2", "Platform 3", "Platform 4"]
    let tempClusterArray = ["Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4"]
    let tempSiteArray = ["Site 1", "Site 2", "Site 3", "Site 4"]
    let tempBoardArray = ["Board 1", "Board 2", "Board 3", "Board 4"]

    
    let pickerView = UIPickerView()
    var toolBar = UIToolbar()
    var lblFilterTitle = UILabel()
    var lblSelctedSubFilter = UILabel()
    var menuIndex = Int()
    var isPickerViewShowing = false
    var selectedFilterMenu = [String]()
    var selectedPickerViewIndex = Int()
    

    @IBOutlet weak var filterTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.pickerView.dataSource = self
         self.pickerView.delegate = self
         self.filterTableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "filter_cell")
        
//        print(selectedFilterMenu)

        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - Creating picker view
    func getpicker()
    {
        if isPickerViewShowing
        {
            self.pickerView.removeFromSuperview()
            self.toolBar.removeFromSuperview()
            self.isPickerViewShowing = false
        }
        isPickerViewShowing = true
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(pickerView)

                          
        //MARK: - Adding tool bar in picker view
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(onPickerCancelButtonTapped)),UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onPickerDoneButtonTapped))]
        
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector( onDoneButtonTapped))

           self.view.addSubview(toolBar)
            
            let selectedMenuPicker = "Menu-\(menuIndex)"
            if let rowItem = UserDefaults.standard.value(forKey: selectedMenuPicker)
            {
                let row = subFiltersArray.firstIndex { $0 == rowItem as! String }
                //print(row)
                pickerView.selectRow(row ?? 0, inComponent: 0, animated: false)
            }
        
    }
    
    //MARK: - Pickerview Cancel button clicked
    @objc func onPickerCancelButtonTapped()
    {
        self.pickerView.removeFromSuperview()
        self.toolBar.removeFromSuperview()
        self.isPickerViewShowing = false
    }
    
    //MARK: - Pickerview Done button clicked
    @objc func onPickerDoneButtonTapped()
    {
        
        let selectedMenuPicker = "Menu-\(menuIndex)"
        print(selectedMenuPicker)
        print(subFiltersArray[selectedPickerViewIndex])
        UserDefaults.standard.set(subFiltersArray[selectedPickerViewIndex], forKey: selectedMenuPicker)

            self.selectedFilterMenu[menuIndex] = subFiltersArray[selectedPickerViewIndex]
            print(subFiltersArray[selectedPickerViewIndex])
            self.lblSelctedSubFilter.text = subFiltersArray[selectedPickerViewIndex]
            self.lblSelctedSubFilter.font =  self.lblSelctedSubFilter.font.withSize(18)
            self.lblFilterTitle.font =  self.lblFilterTitle.font.withSize(14)
        
        self.pickerView.removeFromSuperview()
        self.toolBar.removeFromSuperview()
        self.isPickerViewShowing = false
        print(isPickerViewShowing)
    }
    
    //MARK: - Filter Submit button clicked
    @IBAction func btnSubmitClicked(_ sender: Any) {
        print("Submit clicked")
        self.delegate?.didReceiveFilterResponsee(filterResponse: selectedFilterMenu)
       // print(selectedFilterMenu)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Filter Reset button clicked
    @IBAction func btnResetClicked(_ sender: Any) {
        self.resetPicker()
        self.filterTableView.reloadData()
            }
    
    
    //MARK: - Filter cancel button clicked
    @IBAction func cancelBtnClicked(_ sender: Any) {
        print("Cancel clicked")
        self.resetPicker()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Resetting the all picked values
    func resetPicker()
    {
        self.selectedFilterMenu = ["---","---","---","---","---"]
        
        for i in 0...4
        {
            let selectedMenuPickerObject = "Menu-\(i)"
            UserDefaults.standard.removeObject(forKey: selectedMenuPickerObject)
            UserDefaults.standard.synchronize()
        }
    }
}

extension FilterVC:  UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    //MARK: - Pickerview method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return subFiltersArray.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return subFiltersArray[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedPickerViewIndex = row
            }
    
    
    //MARK: - Tableview method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.filterTableView.dequeueReusableCell(withIdentifier: "filter_cell", for: indexPath) as! FilterCell
        cell.lblSelectedFilter.text = selectedFilterMenu[indexPath.row]
        //print(filterNameArray[indexPath.row])
        if(selectedFilterMenu[indexPath.row] == "---")
        {
            cell.lblFilterTitle.text = filterNameArray[indexPath.row]
            cell.lblFilterTitle.font =  cell.lblFilterTitle.font.withSize(18)
            cell.lblSelectedFilter.font =  cell.lblSelectedFilter.font.withSize(14)
        }
        else{
            cell.lblFilterTitle.text = filterNameArray[indexPath.row]
            cell.lblFilterTitle.font =  cell.lblFilterTitle.font.withSize(14)
            cell.lblSelectedFilter.font =  cell.lblSelectedFilter.font.withSize(18)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterCell
        self.lblSelctedSubFilter = cell.lblSelectedFilter
        self.lblFilterTitle = cell.lblFilterTitle
        self.menuIndex = indexPath.row
        
        //temprory giving temp data
        if(self.menuIndex == 0)
        {
            subFiltersArray = tempSegmentArray
        }else if(self.menuIndex == 1)
        {
            subFiltersArray = tempPlatformArray
        }else if(self.menuIndex == 2)
        {
            subFiltersArray = tempClusterArray
        }else if(self.menuIndex == 3)
        {
            subFiltersArray = tempSiteArray
        }else if(self.menuIndex == 4)
        {
            subFiltersArray = tempBoardArray
        }
        
         self.getpicker()
    }

}

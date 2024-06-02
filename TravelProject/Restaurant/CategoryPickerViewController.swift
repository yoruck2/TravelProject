//
//  CategoryPickerViewController.swift
//  TravelProject
//
//  Created by dopamint on 5/29/24.
//

import UIKit

class CategoryPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let category = ["전체", "한식", "카페", "중식", "분식", "일식", "양식", "경양식"]
    var selectedCategory: String = "전체"
    var selectedCategoryColor: UIColor = #colorLiteral(red: 0, green: 0.1491314173, blue: 0, alpha: 1)
    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet var pickerViewLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPickerViewLabel()
        setUpConfirmButton()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }
    
    func setUpPickerViewLabel() {
        pickerViewLabel.text = "선택한 카테고리만 보이게되요"
        pickerViewLabel.font = UIFont.cellSmall
    }
    
    func setUpConfirmButton() {
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.layer.cornerRadius = 10
        confirmButton.backgroundColor = .lightGray

    }

    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        delegate?.dismissViewController?(label: selectedCategory, color: selectedCategoryColor)
        dismiss(animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return Category.categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategory = Category.categoryList[row]
        selectedCategoryColor = Category(rawValue: selectedCategory)?.categoryColor() ?? UIColor(.gray)
    }
}

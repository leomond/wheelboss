//
//  CarInfoView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/16.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class CarInfoView: UIView {
    
    var carBrand = UILabel()
    var carBrandValue = SelectInputView()
    var carModel = UILabel()
    var carModelValue = SelectInputView()
    var productDate = UILabel()
    var productDateValue = SelectInputView()
    var uploadDrivingLicense = UIImageView()
    var uploadTyre = UIImageView()
    
    var uploadWidth: CGFloat = 150
    var uploadHeight: CGFloat = 150
    
    var drivingLicenseImage: String = "drivinglicense"
    var tyreImage: String = "defaulttyre"
    
    var lineSpace: CGFloat = 13
    var labelWidth: CGFloat = 86
    var contentRatio: CGFloat = 0.9
    
    var space: CGFloat = 26
    
    var height: CGFloat = 44

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let width: CGFloat = (bounds.size.width / 2 - labelWidth) * contentRatio
        carBrand.text = "汽车品牌："
        carBrand.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        carBrand.frame = CGRectMake(0, space, labelWidth, height)
        addSubview(carBrand)
        
        carBrandValue.frame = CGRectMake(labelWidth, space, width, height)
        carBrandValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        carBrandValue.input.placeholder = "请选择品牌"
        carBrandValue.id = "brand"
        addSubview(carBrandValue)
        
        carModel.text = "汽车型号："
        carModel.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        carModel.frame = CGRectMake(0, height + lineSpace + space, labelWidth, height)
        addSubview(carModel)
        
        carModelValue.frame = CGRectMake(labelWidth, height + lineSpace + space, width, height)
        carModelValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        carModelValue.input.placeholder = "请选择型号"
        carModelValue.id = "model"
        addSubview(carModelValue)
        
        productDate.text = "生产年份："
        productDate.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        productDate.frame = CGRectMake(0, (height + lineSpace) * 2 + space, labelWidth, height)
        addSubview(productDate)
        
        productDateValue.frame = CGRectMake(labelWidth, (height + lineSpace) * 2 + space, width, height)
        productDateValue.input.placeholder = "请选择年份"
        productDateValue.backgroundColor = UIColor.groupTableViewBackgroundColor()
        productDateValue.id = "year"
        productDateValue.input.keyboardType = .NumberPad
        addSubview(productDateValue)
        
        let drivingLicenseX: CGFloat = bounds.size.width - width - labelWidth
        uploadDrivingLicense.frame = CGRectMake(drivingLicenseX, space, uploadWidth, uploadHeight)
        uploadDrivingLicense.image = UIImage(named: drivingLicenseImage)
        addSubview(uploadDrivingLicense)
        
        let tyreX: CGFloat = bounds.size.width - uploadWidth
        uploadTyre.frame = CGRectMake(tyreX, space, uploadWidth, uploadHeight)
        uploadTyre.image = UIImage(named: tyreImage)
        addSubview(uploadTyre)
    }

}

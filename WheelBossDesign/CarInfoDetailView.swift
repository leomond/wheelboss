//
//  CarInfoDetailView.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/24.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

class CarInfoDetailView: UIView {
    
    var carBrand = UILabel()
    var carBrandValue = UILabel() {didSet {setNeedsDisplay()}}
    
    var carModel = UILabel()
    var carModelValue = UILabel() {didSet {setNeedsDisplay()}}
    
    var productDate = UILabel()
    var productDateValue = UILabel() {didSet {setNeedsDisplay()}}
    
    var uploadDrivingLicense = UIImageView()
    var uploadTyre = UIImageView()
    
    var uploadWidth: CGFloat = 150
    var uploadHeight: CGFloat = 150
    
    var drivingLicenseImage: String = "drivinglicense" {didSet {setNeedsDisplay()}}
    
    var lineSpace: CGFloat = 13
    var labelWidth: CGFloat = 86
    var contentRatio: CGFloat = 0.9
    
    var space: CGFloat = 26
    
    var height: CGFloat = 36

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
        carBrandValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(carBrandValue)
        
        carModel.text = "汽车型号："
        carModel.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        carModel.frame = CGRectMake(0, space + lineSpace + height, labelWidth, height)
        addSubview(carModel)
        
        carModelValue.frame = CGRectMake(labelWidth, space + lineSpace + height, width, height)
        carModelValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(carModelValue)
        
        productDate.text = "生产年份："
        productDate.textColor = UIColor(red: 16 / 255, green: 17 / 255, blue: 19 / 255, alpha: 1)
        productDate.frame = CGRectMake(0, space + (lineSpace + height) * 2, labelWidth, height)
        addSubview(productDate)
        
        productDateValue.frame = CGRectMake(labelWidth, space + (lineSpace + height) * 2, width, height)
        productDateValue.textColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1)
        addSubview(productDateValue)
        
        let drivingLicenseX: CGFloat = bounds.size.width - width - labelWidth
        uploadDrivingLicense.frame = CGRectMake(drivingLicenseX, space, uploadWidth, uploadHeight)
//        uploadDrivingLicense.image = UIImage(named: drivingLicenseImage)
        addSubview(uploadDrivingLicense)
        
        let tyreX: CGFloat = bounds.size.width - uploadWidth
        uploadTyre.frame = CGRectMake(tyreX, space, uploadWidth, uploadHeight)
//        uploadTyre.image = UIImage(named: tyreImage)
        addSubview(uploadTyre)
    }
    
    func getHeight() -> CGFloat {
        return space * 2 + lineSpace * 2 + height * 3
    }

}

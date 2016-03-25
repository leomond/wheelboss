//
//  CommonStruts.swift
//  WheelBossDesign
//
//  Created by 李秋声 on 16/2/5.
//  Copyright © 2016年 Leomond. All rights reserved.
//

import UIKit

public struct SignInConstants {
    static let LoginStateMark: String = "SignInView.LoginStateMark"
}

public struct URIConstants {
    // "http://114.55.2.170:8080"
    private static let URIPrefix: String = "http://114.55.2.170:8080"
    static let LoginURI: String = URIPrefix + "/wheelboss/store/Auth"
    static let ValidAccessToken: String = URIPrefix + "/wheelboss/store/TokenCheck"
    static let LogOutURI: String = URIPrefix + "/wheelboss/store/Logout"
    static let QuerySeriesList: String = URIPrefix + "/wheelboss/wheelboss/WheelCatagory"
    static let QueryCarInfo: String = URIPrefix + "/wheelboss/Vehicle/VehicleInfo"
    static let OrderConfirm: String = URIPrefix + "/wheelboss/order/OrderSubmit"
    static let QueryStoreInfo: String = URIPrefix + "/wheelboss/store/StoreInfo"
    static let OrderInfoList: String = URIPrefix + "/wheelboss/order/QueryOrder"
    static let OrderDetailInfo: String = URIPrefix + "/wheelboss/order/OrderDetail"
    static let OrderOpereation: String = URIPrefix + "/wheelboss/order/OrderStatusChange"
    static let PwdModify: String = URIPrefix + "/wheelboss/store/ModifyPasswd"
    static let UploadAvatar: String = URIPrefix + "/wheelboss/store/UploadFile"
    static let PicShow: String = URIPrefix + "/wheelboss/pic/PicShow"
}

public struct HomeRightStaff {
    public var background: String
    public var identifier: String
    public init(background: String, identifier: String) {
        self.background = background
        self.identifier = identifier
    }
}

public struct CommonConstants {
    static let ButtonOrder: String = "HomeLeftView.ButtonOrder"
    static let WheelBossDesignTitle: String = "车毂定制"
    static let PicturesTitle: String = "臻品展示"
    static let BuyersShowTitle: String = "买家秀"
    static let ContactUsTitle: String = "联系我们"
    static let DefaultButtonOrder: [String] = [ContactUsTitle, WheelBossDesignTitle, PicturesTitle, BuyersShowTitle]
}

public struct MineLeftMenuCell {
    public var title: String
    public var icon: String
    public var unselectedIcon: String
    public init(title: String, icon: String, unselectedIcon: String) {
        self.title = title
        self.icon = icon
        self.unselectedIcon = unselectedIcon
    }
}

public struct MineLeftMenu {
    static let DefaultMimeLeftMenuOrder: [String] = ["myOrder", "takeAndUpload", "myInfo", "logOut"]
    static let DefaultMimeLeftMenu: Dictionary<String, MineLeftMenuCell> = ["myOrder": MineLeftMenuCell(title: "我的订单", icon: "mine-myOrder-selected", unselectedIcon: "mine-myOrder-unselected"), "takeAndUpload": MineLeftMenuCell(title: "图片管理", icon: "mine-takeAndupload-selected", unselectedIcon: "mine-takeAndupload-unselected"), "myInfo": MineLeftMenuCell(title: "个人信息", icon: "mine-myInfo-selected", unselectedIcon: "mine-myInfo-unselected"), "logOut": MineLeftMenuCell(title: "退出登录", icon: "mine-logout-selected", unselectedIcon: "mine-logout-unselected")]
}

public struct ProductPicture {
    public var lw: String
    public var lf: String
    public var ly: String
    public init() {
        lw = "dzzt-001-M-lw-12"
        lf = "dzzt-001-M-lf-2"
        ly = "dzzt-001-M-ly-1"
    }
}

public struct MyOrderInfoCell {
    public var orderNumber: String // 订单号
    public var orderTime: String // 订单时间
//    public var productPicture: ProductPicture // 商品图片
    public var productSeries: String // 轮毂类型
    public var productModel: String // 轮毂型号
    public var custInfo: String // 客户信息
    public var phone: String // 联系电话
    public var orderState: String // 订单状态
    public var wheelpic: String
    public init() {
        orderNumber = "2016021414240000001"
        orderTime = "2016-02-14 14:24:00"
//        productPicture = ProductPicture()
        wheelpic = ""
        productSeries = "运动型轮毂"
        productModel = "A0001"
        custInfo = "张三，宝马"
        phone = "13211111111"
        orderState = "待生产"
    }
}

public struct WheelBossInfo {
    public var name: String
    public var picture: String
    public var index: Int
    public var displayName: String
    public init(name: String) {
        self.name = name
        self.picture = "hs01-backplate"
        index = -1
        self.displayName = "CGCG\(name)"
    }
    public init(name: String, picture: String) {
        self.name = name
        self.picture = picture
        index = -1
        self.displayName = "CGCG\(name)"
    }
    public init() {
        name = "001"
        picture = "hs01-backplate"
        index = -1
        self.displayName = "CGCG\(name)"
    }
}

public struct WheelColorInfo {
    static let Colors: Dictionary<String, String> = ["0": "原色","1": "透明红", "2": "透明金", "3": "透明咖啡", "4": "透明蓝", "5": "透明黑", "6": "透明古铜", "10": "亮黑", "11": "中闪银", "12": "枪灰", "13": "亚黑", "14": "黄色", "15": "白色"]
}

public struct OrderConfirmInfo {
    static let DefalutOrderInfoValueTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let CarInfoIdentifier: String = "OrderConfirmViewController.CarInfoIdentifier"
    static let CenterCoverInfo = ["CGCG盖": "01", "原车盖": "02"]
    static let ResverCenterCoverInfo = ["01": "CGCG盖", "02": "原车盖"]
    static let TirePressureHoleInfo = ["是": "01", "否": "02"]
    static let ResverTirePressureHoleInfo = ["01": "是", "02": "否"]
    static let BrakeDiscInfo = ["未修改": "01", "修改过": "02"]
    static let ResverBrakeDiscInfo = ["01": "未修改", "02": "修改过"]
    static let ProductionTechnologyInfo = ["全涂装": "S",
        "全亮面": "M",
        "全拉丝": "L",
        "车面不车边": "A",
        "表面拉丝": "B",
        "车边不车面": "D",
        "电镀": "C",
        "真空电镀": "V",
        "包边": "E",
        "铣窗口": "W",
        "套色": "T",
        "包边+套色": "H",
        "精抛": "P"]
    static let ResverProductionTechnologyInfo = ["S": "全涂装",
        "M": "全亮面",
        "L": "全拉丝",
        "A": "车面不车边",
        "B": "表面拉丝",
        "D": "车边不车面",
        "C": "电镀",
        "V": "真空电镀",
        "E": "包边",
        "W": "铣窗口",
        "T": "套色",
        "H": "包边+套色",
        "P": "精抛"]
}

public struct MyBusinessInfo {
    static let StoreInfoIdentifier: String = "MyBusinessViewController.StoreInfo"
}

public struct PicturesInfo {
    public var id: String
    public var fullscreenUrl: String
    public var listUrl: String
    public var chromaticalname: String // 颜色名称
    public var technical: String
    public var wheelseriesname: String
    public var wheeltype: String
    public var chromaticalid: String
    public init() {
        id = ""
        fullscreenUrl = ""
        listUrl = ""
        chromaticalname = ""
        technical = ""
        wheelseriesname = ""
        wheeltype = ""
        chromaticalid = ""
    }
}
//
//  ZJDKit.h
//  ZJDKit
//
//  Created by aidong on 2018/1/15.
//

#ifndef ZJDKit_h
#define ZJDKit_h

#ifdef __OBJC__

// 系统基本框架
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

// 我的基本方法
#import "BasicViewController.h"
#import "ZJD_Macros.h"
#import "ToolClass.h"
#import "UITools.h"

// 网络相关
#import "ZJD_Networking.h"
#import "ZJD_ResourceFile.h"
#import "ZJD_FileManager.h"
#import "ZJD_FileManageUnit.h"

// view
#import "ZJD_Button.h"
#import "ZJD_TableView.h"

// 类目、延展
#import "UIColorHeader.h"
#import "NSDate+Utils.h"
#import "UIControl+RecurResponse.h"
#import "UITableView+ZJDAdd.h"
#import "UITableViewCell+ZJDAdd.h"
#import "UIView+Gesture.h"
#import "UINavigationBar+Other.h"
#import "MBProgressHUD+Additions.h"
#import "UIImageView+toBig.h"
#import "UIImageView+ZJDAdd.h"
#import "UILabel+EdgeInsert.h"
#import "UILabel+SetLabelSpace.h"
#import "UIViewController+ZJDAdd.h"

// 获取手机UUID 唯一
#import "ZJDKeyChainDataManager.h"

// 刷新 和 空数据展示
#import "UIScrollView+ZJDRefresh.h"
#import "UIScrollView+ZJDEmptyDataSet.h"

// HDAlertView
#import "NSString+HDExtension.h"
#import "UIImage+HDExtension.h"
#import "UIView+Extension.h"

#endif


#endif /* ZJDKit_h */

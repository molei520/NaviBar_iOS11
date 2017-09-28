//
//  ResultViewController.h
//  NaviBar_iOS11
//
//  Created by zhangMo on 2017/9/27.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (nonatomic, strong) NSArray *dataArray;

- (void)reloadData;

@end

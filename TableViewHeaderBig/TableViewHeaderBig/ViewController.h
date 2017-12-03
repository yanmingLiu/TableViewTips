//
//  ViewController.h
//  TableViewHeaderBig
//
//  Created by lym on 2017/2/1.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

/* 状态栏高度 */
#define kStatusBarH     CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
/* NavBar高度 */
#define kNavigationBarH CGRectGetHeight(self.navigationController.navigationBar.frame)
/* 导航栏 高度 */
#define kNavigationH   (kStatusBarH + kNavigationBarH)

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


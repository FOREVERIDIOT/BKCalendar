//
//  BKExampleDetailsViewController.h
//  BKCalendar
//
//  Created by zhaolin on 2018/10/17.
//  Copyright © 2018年 BIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKExampleDetailsViewController : UIViewController

/**
 功能
 */
@property (nonatomic,strong) NSString * function;
/**
 根据indexPath判断方法
 */
@property (nonatomic,strong) NSIndexPath * indexPath;

@end

NS_ASSUME_NONNULL_END

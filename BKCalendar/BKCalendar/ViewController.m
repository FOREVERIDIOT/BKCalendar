//
//  ViewController.m
//  BKCalendar
//
//  Created by BIKE on 2018/10/15.
//  Copyright © 2018年 BIKE. All rights reserved.
//

#import "ViewController.h"
#import "BKCalendar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    calendarBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [calendarBtn setTitle:@"日历" forState:UIControlStateNormal];
    [calendarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    calendarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [calendarBtn addTarget:self action:@selector(calendarBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calendarBtn];
}

-(void)calendarBtnClick
{
    BKCalendarViewController * vc = [[BKCalendarViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

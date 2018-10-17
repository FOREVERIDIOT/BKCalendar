//
//  BKExampleDetailsViewController.m
//  BKCalendar
//
//  Created by zhaolin on 2018/10/17.
//  Copyright © 2018年 BIKE. All rights reserved.
//

#import "BKExampleDetailsViewController.h"
#import "BKPickerView.h"
#import "BKCalendar.h"

@interface BKExampleDetailsViewController ()

@property (nonatomic,strong) UILabel * selectDateLab;
@property (nonatomic,strong) UILabel * calcDateLab;

@property (nonatomic,strong) BKPickerView * datePicker;
@property (nonatomic,strong) NSDate * selectDate;

@end

@implementation BKExampleDetailsViewController

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"例子";
    self.view.backgroundColor = [UIColor whiteColor];
    _selectDate = [NSDate date];
    
    UILabel * functionMarkLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 250, 20)];
    functionMarkLab.textColor = [UIColor blackColor];
    functionMarkLab.font = [UIFont systemFontOfSize:16];
    functionMarkLab.text = self.function;
    [self.view addSubview:functionMarkLab];
    
    _selectDateLab = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(functionMarkLab.frame) + 20, 150, 40)];
    _selectDateLab.textColor = [UIColor blackColor];
    _selectDateLab.font = [UIFont systemFontOfSize:16];
    _selectDateLab.textAlignment = NSTextAlignmentCenter;
    _selectDateLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _selectDateLab.layer.borderWidth = 1;
    [self.view addSubview:_selectDateLab];
    
    UIButton * selectDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectDateBtn.frame = CGRectMake(CGRectGetMaxX(_selectDateLab.frame) + 10, CGRectGetMinY(_selectDateLab.frame), 80, 40);
    [selectDateBtn setTitle:@"选择时间" forState:UIControlStateNormal];
    [selectDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectDateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [selectDateBtn addTarget:self action:@selector(selectDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectDateBtn];
    
    UILabel * calcMarkLab = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_selectDateLab.frame) + 20, 150, 20)];
    calcMarkLab.textColor = [UIColor blackColor];
    calcMarkLab.font = [UIFont systemFontOfSize:16];
    calcMarkLab.text = @"计算结果:";
    [self.view addSubview:calcMarkLab];
    
    _calcDateLab = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(calcMarkLab.frame) + 20, 150, 40)];
    _calcDateLab.textColor = [UIColor blackColor];
    _calcDateLab.font = [UIFont systemFontOfSize:16];
    _calcDateLab.textAlignment = NSTextAlignmentCenter;
    _calcDateLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _calcDateLab.layer.borderWidth = 1;
    [self.view addSubview:_calcDateLab];
    
    [self calcDate];
}

-(void)selectDateBtnClick
{
    BKPickerView * pickerView = [[BKPickerView alloc] initWithPickerStyle:BKPickerStyleDate remind:@"选择时间"];
    pickerView.selectDate = _selectDate;
    [pickerView setConfirmSelectDateCallback:^(NSDate *date) {
        self.selectDate = date;
        [self calcDate];
    }];
    [pickerView showInView:self.view];
}

-(void)calcDate
{
    _selectDateLab.text = [self formatterDate:_selectDate];
    
    switch (self.indexPath.section) {
        case 0:
        {
            switch (self.indexPath.row) {
                case 0:
                {
                    _calcDateLab.text = [NSString stringWithFormat:@"%ld",[_selectDate calcYearNumber]];
                }
                    break;
                case 1:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getYearDateAccordingToGapsNumber:1]];
                }
                    break;
                case 2:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getFirstDayInYear]];
                }
                    break;
                case 3:
                {
                    _calcDateLab.text = [NSString stringWithFormat:@"%ld",[_selectDate getNumberOfDaysPerYear]];
                }
                    break;
                case 4:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getLastDayInYear]];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (self.indexPath.row) {
                case 0:
                {
                    _calcDateLab.text = [NSString stringWithFormat:@"%ld",[_selectDate calcMonthNumber]];
                }
                    break;
                case 1:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getMonthDateAccordingToGapsNumber:1]];
                }
                    break;
                case 2:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getFirstDayInMonth]];
                }
                    break;
                case 3:
                {
                    _calcDateLab.text = [NSString stringWithFormat:@"%ld",[_selectDate getNumberOfDaysPerMonth]];
                }
                    break;
                case 4:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getLastDayInMonth]];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (self.indexPath.row) {
                case 0:
                {
                    _calcDateLab.text = [NSString stringWithFormat:@"%ld",[_selectDate calcDayNumberInMonth]];
                }
                    break;
                case 1:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getDayDateAccordingToGapsNumber:1]];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (self.indexPath.row) {
                case 0:
                {
                    NSInteger week = [_selectDate calcCurrentDateWeek];
                    switch (week) {
                        case 0:
                        {
                            _calcDateLab.text = @"星期天";
                        }
                            break;
                        case 1:
                        {
                            _calcDateLab.text = @"星期一";
                        }
                            break;
                        case 2:
                        {
                            _calcDateLab.text = @"星期二";
                        }
                            break;
                        case 3:
                        {
                            _calcDateLab.text = @"星期三";
                        }
                            break;
                        case 4:
                        {
                            _calcDateLab.text = @"星期四";
                        }
                            break;
                        case 5:
                        {
                            _calcDateLab.text = @"星期五";
                        }
                            break;
                        case 6:
                        {
                            _calcDateLab.text = @"星期六";
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                case 1:
                {
                    _calcDateLab.text = [self formatterDate:[_selectDate getWeekDateAccordingToGapsNumber:1]];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            switch (self.indexPath.row) {
                case 0:
                {
                    _calcDateLab.text = [_selectDate getChineseYearNumber];
                }
                    break;
                case 1:
                {
                    _calcDateLab.text = [_selectDate getChineseNumber];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

-(NSString*)formatterDate:(NSDate*)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    return [dateFormatter stringFromDate:date];
}

@end

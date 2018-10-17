//
//  BKCalendarExampleViewController.m
//  BKCalendar
//
//  Created by zhaolin on 2018/10/17.
//  Copyright © 2018年 BIKE. All rights reserved.
//

#import "BKCalendarExampleViewController.h"
#import "BKExampleDetailsViewController.h"
#import "BKCalendar.h"

NS_INLINE BOOL is_iPhoneX_series() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        if (window.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

NS_INLINE CGFloat get_system_nav_height() {
    return is_iPhoneX_series() ? (44.f+44.f) : 64.f;
}

#define POINTS_FROM_PIXELS(__PIXELS) (__PIXELS / [[UIScreen mainScreen] scale])
#define ONE_PIXEL POINTS_FROM_PIXELS(1.0)

NSString * const kExampleTableCellID = @"kExampleTableCellID";
NSString * const kExampleTableSectionHeaderID = @"kExampleTableSectionHeaderID";

@interface BKCalendarExampleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * sectionDataArr;
@property (nonatomic,strong) NSArray * rowDataArr;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation BKCalendarExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"例子列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

-(NSArray *)sectionDataArr
{
    if (!_sectionDataArr) {
        _sectionDataArr = @[@"关于年",@"关于月",@"关于天",@"关于星期",@"中国日历",@"日历例子"];
    }
    return _sectionDataArr;
}

-(NSArray *)rowDataArr
{
    if (!_rowDataArr) {
        _rowDataArr = @[@[@"计算date的年份",@"根据间隔数获取某年date",@"获取当年第一天",@"获取当年有多少天数",@"获取当年最后一天"],
                        @[@"计算date的月份",@"根据间隔数获取某月date",@"获取当月第一天",@"获取当月有多少天数",@"获取当月最后一天"],
                        @[@"计算date在一月中是几号",@"根据间隔数获取某天date"],
                        @[@"获取当日为星期几",@"根据间隔数获取某星期date"],
                        @[@"获取中国年份",@"获取中国日期"],
                        @[@"日历例子"]];
    }
    return _rowDataArr;
}

#pragma mark - UITableView

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, get_system_nav_height(), self.view.frame.size.width, self.view.frame.size.height - get_system_nav_height()) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.sectionHeaderHeight = 40;
        _tableView.rowHeight = 40;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kExampleTableCellID];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kExampleTableSectionHeaderID];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionDataArr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowDataArr[section] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kExampleTableCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel * titleLab = (UILabel*)[cell viewWithTag:1];
    if (!titleLab) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width - 60, 40)];
        titleLab.tag = 1;
        titleLab.textColor = [UIColor grayColor];
        titleLab.font = [UIFont systemFontOfSize:15];
        [cell addSubview:titleLab];
    }
    
    UIImageView * line = (UIImageView*)[cell viewWithTag:2];
    if (!line) {
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 - ONE_PIXEL, self.view.frame.size.width, ONE_PIXEL)];
        line.backgroundColor = [UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1];
        line.tag = 2;
        [cell addSubview:line];
    }
    
    titleLab.text = self.rowDataArr[indexPath.section][indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kExampleTableSectionHeaderID];
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLab = (UILabel*)[headerView viewWithTag:1];
    if (!titleLab) {
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 30, 40)];
        titleLab.tag = 1;
        titleLab.textColor = [UIColor darkGrayColor];
        titleLab.font = [UIFont systemFontOfSize:17];
        [headerView addSubview:titleLab];
    }
    
    UIImageView * line = (UIImageView*)[headerView viewWithTag:2];
    if (!line) {
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 - ONE_PIXEL, self.view.frame.size.width, ONE_PIXEL)];
        line.backgroundColor = [UIColor colorWithRed:204.0/255.0f green:204.0/255.0f blue:204.0/255.0f alpha:1];
        line.tag = 2;
        [headerView addSubview:line];
    }
    
    titleLab.text = self.sectionDataArr[section];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5 && indexPath.row == 0) {
        BKCalendarViewController * vc = [[BKCalendarViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        BKExampleDetailsViewController * vc = [[BKExampleDetailsViewController alloc] init];
        vc.function = self.rowDataArr[indexPath.section][indexPath.row];
        vc.indexPath = indexPath;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

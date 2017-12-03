//
//  ViewController.m
//  TableViewHeaderBig
//
//  Created by lym on 2017/2/1.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"

#import "YMHeaderViewBlowUpController.h"
#import "YMMultipleChoiceController.h"
#import "YMChoiceController.h"

static NSString *const cellId = @"cellId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView; 

@property (nonatomic, strong) NSArray * dataArray; 
@end

@implementation ViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }
        
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"tableViewHeader下拉放大", @"cell单选", @"cell多选"];
    
    
    [self.view addSubview:self.tableView];
    
    // 设置滚动区域
    //self.tableView.contentInset = UIEdgeInsetsMake(kNavigationH, 0, 0, 0 );
    // 设置滚动指示器的位置
    //self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //cell右边箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //cell的下划线
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //下划线颜色
    self.tableView.separatorColor = [UIColor blueColor];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // cell点击动画效果：有背景色-自动消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    
    switch (indexPath.row) {
        case 0:
            vc = [[YMHeaderViewBlowUpController alloc] init];
            break;
        case 1:
            vc = [[YMChoiceController alloc] init];
            break;
        case 2:
            vc = [[YMMultipleChoiceController alloc] init];
            break;
        case 3:

            break;
            
        default:
            break;
    }
    
    [self showViewController:vc sender:nil];
}


#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        
        //去掉所有cell分割线
        //_tabelView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        // 去掉多余cell分割线
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}

@end

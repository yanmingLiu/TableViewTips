//
//  YMHeaderViewBlowUpController.m
//  TableViewHeaderBig
//
//  Created by lym on 2017/2/3.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "YMHeaderViewBlowUpController.h"

#import "UIView+Frame.h"

/* 状态栏高度 */
#define kStatusBarH     CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
/* NavBar高度 */
#define kNavigationBarH CGRectGetHeight(self.navigationController.navigationBar.frame)
/* 导航栏 高度 */
#define kNavigationH   (kStatusBarH + kNavigationBarH)

static CGFloat headerH = 200;

static NSString *const cellId = @"cellId";

@interface YMHeaderViewBlowUpController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView; 
@property (nonatomic, strong) UIView * headerView; 
@property (nonatomic, strong) UIImageView * headerImageView; 
@property (nonatomic, assign) UIStatusBarStyle  statusBarStyle; 

@end

@implementation YMHeaderViewBlowUpController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(headerH, 0, 0, 0 );
    // 设置滚动指示器的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self setupUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

#pragma makr - setupUI

- (void)setupUI {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headerH)];
    self.headerView.backgroundColor = [UIColor colorWithRed:247.00/255 green:247.00/255 blue:247.00/255 alpha:1];
    [self.view addSubview:self.headerView];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:self.headerView.bounds];
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.image = [UIImage imageNamed:@"10"];
    
    [self.headerView addSubview:self.headerImageView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView  {
    
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
    
    if (offset <= 0) { // 下拉
        
        self.headerView.y = 0;
        self.headerView.height = headerH - offset;
        self.headerImageView.alpha = 1;
        
    }else { // 上拉
        
        self.headerView.height = headerH;
        
        // 设置headerView 最小Y值 模拟导航栏
        CGFloat minY = headerH - kNavigationH;
        self.headerView.y = -MIN(minY,offset);
        
        // 设置透明度
        CGFloat scale = 1 - (offset / minY);
        self.headerImageView.alpha = scale;
        
        // 设置状态栏
        self.statusBarStyle = scale < 0.5 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    
    self.headerImageView.height = self.headerView.height;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    /*
    /// 表格性能优化方法：1.Runloop 2. 开启栅格化 & 异步加载
    // 1.栅格化
    cell.layer.shouldRasterize = true;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // 2.异步加载
    cell.layer.drawsAsynchronously = true;
    */
     
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}

@end

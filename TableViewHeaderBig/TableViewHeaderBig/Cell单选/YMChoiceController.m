//
//  YMChoiceController.m
//  TableViewHeaderBig
//
//  Created by lym on 2017/12/3.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "YMChoiceController.h"

static NSString *const cellId = @"cellId";

@interface YMChoiceController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView; 

@property (assign, nonatomic) NSIndexPath *selIndexPath;//单选，当前选中的行

@end

@implementation YMChoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"cell单选";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    //当上下拉动的时候，因为cell的复用性，需要重新判断
    if (self.selIndexPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // cell点击动画效果：有背景色-自动消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //之前选中的，取消选择
    UITableViewCell *celled = [tableView cellForRowAtIndexPath:self.selIndexPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    
    //记录当前选中的位置索引
    self.selIndexPath = indexPath;
    
    //当前选中
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        
        // 去掉多余cell分割线
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}
@end

//
//  YMMultipleChoiceController.h
//  TableViewHeaderBig
//
//  Created by lym on 2017/2/3.
//  Copyright © 2017年 liuyanming. All rights reserved.
//

#import "YMMultipleChoiceController.h"

static NSString *const cellId = @"cellId";

@interface YMMultipleChoiceController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView; 

@property (strong, nonatomic) NSMutableArray *selectIndexs;//多选选中的行
@end

@implementation YMMultipleChoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"cell多选";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    //设置选中
    cell.accessoryType = UITableViewCellAccessoryNone;
    for (NSIndexPath *index in _selectIndexs) {
        if (index == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark; 
            break;
        }
    }
    
    return cell;
}

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // cell点击动画效果：有背景色-自动消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取到点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) { //如果为选中状态
        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
        [_selectIndexs removeObject:indexPath]; //数据移除
    }else { //未选中
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        [_selectIndexs addObject:indexPath]; //添加索引数据到数组
    }
    
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        
        //允许多选
       _tableView.allowsMultipleSelection = YES;
        
        // 去掉多余cell分割线
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}

@end

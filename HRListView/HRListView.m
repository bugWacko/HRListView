//
//  HRListView.m
//  CXPhotoBrower
//
//  Created by 陈晨昕 on 2017/6/13.
//  Copyright © 2017年 bugWacko. All rights reserved.
//

#import "HRListView.h"

#define TableHeight 45.0 //列表高度
#define MinWidthForTableWidth 100.0 //列表最小宽度
#define MinNumberForTableList 6 //列表最大展示条数
#define TableCellLabelFont 14 //列表标题字体大小
#define AnimationTime 0.4 //出现、消失动画时间

@interface HRListView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (assign, nonatomic) CGFloat viewHeight;//视图高度

@end

@implementation HRListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewHeight = 0.0;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //设置阴影
        [self.layer setShadowColor:[UIColor grayColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(3, 3)];
        [self.layer setShadowRadius:3.0f];
        [self.layer setShadowOpacity:1];
        
        [self initializeDefault];
    }
    return self;
}

/**
 * 初始化
 */
-(void)initializeDefault {

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
}

/**
 * set fun
 */
-(void)setItemArray:(NSArray *)itemArray {
    //如果需要数据转换可以在此进行数据转换
    _itemArray = itemArray;
}

-(void)setObject:(id)object {
    
    _object = object;

    //计算view高、宽
    CGFloat width = 0.0;
    UIView * view = object;
    if (view.frame.size.width < MinWidthForTableWidth) {
        width = MinWidthForTableWidth;
    } else {
        width = view.frame.size.width;
    }

    if (_itemArray.count > MinNumberForTableList) {
        _viewHeight = MinNumberForTableList * TableHeight;
    } else {
        _viewHeight = _itemArray.count * TableHeight;
    }
    
    //判断展示方向
    if (_type == HRListShowTypeDown) {//向下展示
        [self setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y + view.frame.size.height, width, _viewHeight)];
        
    } else if (_type == HRListShowTypeUp) {//向上展示
        [self setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, width, _viewHeight)];
    }
    
    [self.tableView setFrame:self.bounds];
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellID = @"HRTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:TableCellLabelFont]];
    cell.textLabel.text = self.itemArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return TableHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * value = self.itemArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(HRListView:withIndex:withValue:)]) {
        [self.delegate HRListView:self withIndex:indexPath.row withValue:value];
    }
    
    [self dimiss];
}

#pragma mark - public method

/**
 *  展示
 */
-(void)show {

    UIView * view = _object;
    [view.superview addSubview:self];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    [self.tableView setFrame:self.bounds];
    
    [UIView animateWithDuration:AnimationTime animations:^{
        if (_type == HRListShowTypeDown) {//向下展示
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _viewHeight);
            [self.tableView setFrame:self.bounds];
            
        } else if (_type == HRListShowTypeUp) {//向上展示
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - _viewHeight, self.frame.size.width, _viewHeight);
            [self.tableView setFrame:self.bounds];
        }
    }];
}

/**
 * 消失
 */
-(void)dimiss {

    [UIView animateWithDuration:AnimationTime animations:^{
        if (_type == HRListShowTypeDown) {//向下展示
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
            [self.tableView setFrame:self.bounds];
            
        } else if (_type == HRListShowTypeUp) {//向上展示
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + _viewHeight, self.frame.size.width, 0);
            [self.tableView setFrame:self.bounds];
        }
        
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)dealloc {
    //释放后执行方法
    NSLog(@"dealloc");
}

@end

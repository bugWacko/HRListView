//
//  HRListView.h
//  CXPhotoBrower
//
//  Created by 陈晨昕 on 2017/6/13.
//  Copyright © 2017年 bugWacko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HRListShowTypeDown = 0, //默认向下展示
    HRListShowTypeUp = 1, //向上展示
} HRListShowType;

@protocol HRListViewDelegate;
@interface HRListView : UIView

/**
 * 数据数组
 */
@property (strong, nonatomic) NSArray * itemArray;

/**
 * 触发对象（button\action ...）
 */
@property (strong, nonatomic) id object;

/**
 * 列表展示方向
 */
@property (assign, nonatomic) HRListShowType type;

/**
 * delegate
 */
@property (weak, nonatomic) id<HRListViewDelegate>delegate;

/**
 *  展示
 */
-(void)show;

/**
 * 消失
 */
-(void)dimiss;

@end

@protocol HRListViewDelegate <NSObject>

-(void)HRListView:(HRListView *)view withIndex:(NSInteger )index withValue:(NSString *)value;

@end

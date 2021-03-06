//
//  CZHTableView.m
//  CZHTestAli
//
//  Created by 阿木 on 2018/8/14.
//  Copyright © 2018年 阿木. All rights reserved.
//

#import "CZHTableView.h"
#import "UIView+Frame.h"

#define kRowHeight 50.f

@interface CZHTableView() <UITableViewDataSource, UITableViewDelegate>

@end

static NSString *tableViewCell = @"UITableViewCell";

@implementation CZHTableView

/**
 tabview构造方法
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - Set方法
-(void)setRowNumber:(NSInteger)rowNumber {
    _rowNumber = rowNumber;
    
    // 重置高度为：行数（rowNumber） *  行高（kRowHeight）
    self.CZH_height = rowNumber * kRowHeight;
    
    [self reloadData];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowNumber;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行", (long)indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"这是第%ld行", (long)indexPath.row];
    CZHLog(@"%@",str);
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.contentOffsetAction) {
        self.contentOffsetAction(scrollView.contentOffset.y);
    }
}

#pragma mark - 超出的部分可以点击
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end

//
//  FoldLineView.h
//  折线图
//
//  Created by superMan on 16/9/22.
//  Copyright © 2016年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoldLineView : UIView

// 测试数据 28 29 30 1 2 3 4 号
@property(nonatomic,strong)NSMutableArray *numbers;
//测试数据 里程数组
@property(nonatomic,strong)NSMutableArray *kmArr;
//测试数据 时间数组
@property(nonatomic,strong)NSMutableArray *timeArr;
@end

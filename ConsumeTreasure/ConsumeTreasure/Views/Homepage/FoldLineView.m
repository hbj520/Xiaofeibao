//
//  FoldLineView.m
//  折线图
//
//  Created by superMan on 16/9/22.
//  Copyright © 2016年 superMan. All rights reserved.
//

#import "FoldLineView.h"
#import "Masonry.h"

@interface FoldLineView ()

//坐标点数组
@property(nonatomic,strong)NSMutableArray *pointArr;
//定时器
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)CAShapeLayer *shapeLayer;
@end

@implementation FoldLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setTimeArr:(NSMutableArray *)timeArr{
    _timeArr = timeArr;
    [self setUI];
}
-(void)setUI{
    
    //每个日期之间的间距 -- 54
    CGFloat space = (self.bounds.size.width - 60) / (7- 1) ;
//    NSLog(@"%f",space);
    //循环添加日期标签
    for (int i = 0; i< self.numbers.count; i++ ) {
  
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + i * space, 180, 20, 20)];
        numberLabel.text = self.numbers[i];
        numberLabel.font = [UIFont systemFontOfSize:16];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLabel];
    }
    //找最大里程数
    //这个地方的逻辑是: 找到这组数据中的最大值,然后根据最大值,选择一个合适的数值当做最大值,然后根据数组里的值等比例安排各个点的位置
    CGFloat maxKM = 0;
    for (int i = 0; i< self.numbers.count - 1 ; i++ ) {
        if ([self.kmArr[i] doubleValue] > [self.kmArr[i+1] doubleValue]) {
            maxKM = [self.kmArr[i] doubleValue];
        }else{
            maxKM = [self.kmArr[i + 1] doubleValue];
        }
    };
    //NSLog(@"%f",[self.kmArr[0] doubleValue] /maxKM);
    //最大里程设置为高度90% 求出最大值
    maxKM = maxKM / 0.9;
    //求出坐标点在线上的比例
    self.pointArr = [NSMutableArray array];
    for (int i = 0; i< self.numbers.count; i++ ) {
        [self.pointArr addObject:[NSString stringWithFormat:@"%f",[self.kmArr[i] doubleValue] /maxKM]];
    }
    //NSLog(@"%@",self.pointArr);


    //添加七根线
    for (int i = 0; i< self.numbers.count; i++ ) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20 + i * space + 9, 0, 1, 180)];
        [self addSubview:lineView];
        //给线添加渐变
        CAGradientLayer *lineLayer = [CAGradientLayer layer];
        lineLayer.frame = lineView.bounds;
        [lineView.layer addSublayer:lineLayer];
        //颜色分配
        lineLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                              (__bridge id)[UIColor colorWithRed:221/255.0 green:223/255.0 blue:225/255.0 alpha:0.6f].CGColor,
                              (__bridge id)[UIColor clearColor].CGColor,];
        lineLayer.locations  = @[@(0),@(1)];
        // 起始点
        lineLayer.startPoint = CGPointMake(0.5, 0);
        
        // 结束点
        lineLayer.endPoint   = CGPointMake(0.5,1);
    }
    
    //根据点划线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i< self.numbers.count; i++ ) {
        
        if (i == 0 ) {
            //这个地方加9 是因为为了让点在最中间
            [path moveToPoint:CGPointMake(20 + 9, 6 + 170 * (1 - [self.pointArr[0]  doubleValue]))];
        }else{
            [path addLineToPoint:CGPointMake(20 + space * i + 9,4 + 170 * (1 - [self.pointArr[i] doubleValue]))];
        }
    }
    self.shapeLayer = [[CAShapeLayer alloc]init];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.shapeLayer.lineWidth = 1.f;
    self.shapeLayer.path = path.CGPath;
    
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    [self.layer addSublayer:self.shapeLayer];
    //将定时器 手动添加运行循环,防止滑动时候动画停止
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(add) userInfo:nil repeats:YES];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    [currentRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    //根据坐标绘制点
    for (int i = 0; i< self.numbers.count; i++ ) {
        
        CGFloat point = [self.pointArr[i] doubleValue];
//        NSLog(@"%f",point);
        UIView *pointView = [[UIView alloc]initWithFrame:CGRectMake(20 + i * space + 4, 170 * (1 - point ), 10, 10)];
        pointView.backgroundColor = [UIColor whiteColor];
        pointView.layer.borderWidth = 2;
        pointView.layer.borderColor = [UIColor orangeColor].CGColor;
        pointView.layer.cornerRadius = 5;
        pointView.layer.masksToBounds = YES;
        [self addSubview:pointView];
        
        //添加标签
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = [UIFont systemFontOfSize:9];
        textLabel.textColor = [UIColor lightGrayColor];
        textLabel.text = [NSString stringWithFormat:@"%@/%@",self.kmArr[i],self.timeArr[i]];
        [textLabel sizeToFit];
        [self addSubview:textLabel];
        //这里我使用了masonry做约束
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(pointView.mas_top).offset(- 5);
            make.centerX.mas_equalTo(pointView.mas_centerX);
        }];
    }
}
//做动画
-(void)add{
    
    if (self.shapeLayer.strokeEnd < 1.0) {
        CGFloat add = 1.0 / (self.numbers.count + 3);
        NSLog(@"add-->>%f",add);
        self.shapeLayer.strokeEnd += add;
        NSLog(@"%f",self.shapeLayer.strokeEnd);
    }else{
        //取消定时器
        [self.timer invalidate];
        self.timer = nil;
    }
    
}


@end

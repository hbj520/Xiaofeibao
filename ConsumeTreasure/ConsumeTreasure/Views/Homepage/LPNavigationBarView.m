//
//  LPNavigationBarView.m
//  LovePlayNews
//
//  Created by tanyang on 16/8/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "LPNavigationBarView.h"

@interface LPNavigationBarView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation LPNavigationBarView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.backBtn.hidden = self.viewController.navigationController.viewControllers.count <= 1;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha
{
    _backgroundAlpha = backgroundAlpha;
    if (_backgroundView) {
        _backgroundView.alpha = backgroundAlpha;
    }
}

#pragma mark - action

- (IBAction)navBackAction:(id)sender
{
    if (_navBackHandle) {
        _navBackHandle();
    }else {
        UIViewController *VC = [self viewController];
        if (VC && VC.navigationController) {
            [VC.navigationController popViewControllerAnimated:YES];
        }
    }
}

//通过view获取controller
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

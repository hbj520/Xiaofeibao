//
//  ImageViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIActionSheetDelegate>
{
    NSString *imageOne;
}
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (IBAction)addNewImage:(id)sender {
    
    [self pickPhotosWithTag:333];
}

- (void)pickPhotosWithTag:(NSInteger)tagg{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    action.tag = tagg;
    [action showInView:self.navigationController.view];
}

#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    __weak typeof(self) weakSelf = self;
    if (buttonIndex == 0) {
        [self openCamera];
        
    }else{
        [self openPhoto];
        
    }
    self.imageBlock = ^(UIImage *img){
        if (actionSheet.tag == 333) {
            //上传图片
            
            [[MyAPI sharedAPI] postFilesWithFormData:@[img] result:^(BOOL success, NSString *msg, id object) {
                if (success) {
                    imageOne = (NSString*)object;
                    [weakSelf.chooseBtn setImage:img forState:0];
                    [weakSelf.theImage setImage:img];
                }else{
                    if ([msg isEqualToString:@"-1"]) {
                        [weakSelf logout];
                    }
                    [weakSelf showHint:msg];
                }
            } errorResult:^(NSError *enginerError) {
                [weakSelf showHint:@"异常错误"];
            }];
            
        }
        
    };
   
}

- (IBAction)makeSureImage:(id)sender {

    if (self.imgBlock) {
        self.imgBlock(imageOne);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

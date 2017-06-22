//
//  ImageViewController.m
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 16/12/29.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
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
    if ([self.imageArray[1] isEqualToString:@"1"]) {
        self.navigationItem.title = @"营业执照";
    }else if ([self.imageArray[1] isEqualToString:@"2"]) {
        self.navigationItem.title = @"经营许可证";
    }else if ([self.imageArray[1] isEqualToString:@"3"]) {
        self.navigationItem.title = @"身份证正面";
    }else{
        self.navigationItem.title = @"身份证反面";
    }
    
    [self.theImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:[UIImage imageNamed:@"upload_yyzz_720"]];
    
}
- (IBAction)addNewImage:(id)sender {
    
    [self pickPhotosWithTag:333];
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pickPhotosWithTag:(NSInteger)tagg{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从照片库选取",nil];
    action.tag = tagg;
    [action showInView:self.navigationController.view];
}

#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex == 0) {
        [self openCamera];
        
    }else if(buttonIndex == 1){
       [self openPhoto];
       
    }
    
            
    
   
}

- (IBAction)makeSureImage:(id)sender {

    if (self.imgBlock) {
        self.imgBlock(imageOne);
    }
    [self backTolastPage];
}
- (void)selectPhotos:(NSMutableArray *)array{
    //上传图片
    __weak  ImageViewController *weakSelf = self;
    self.theImage.image = array[0];
    [self.chooseBtn setImage:array[0] forState:0];
    [[MyAPI sharedAPI] postFilesWithFormData:array result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            imageOne = (NSString*)object;
            
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

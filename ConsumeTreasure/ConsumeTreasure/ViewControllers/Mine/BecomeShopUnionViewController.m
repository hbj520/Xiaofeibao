//
//  BecomeShopUnionViewController.m
//  ConsumeTreasure
//
//  Created by youyou on 11/28/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "BecomeShopUnionViewController.h"

@interface BecomeShopUnionViewController ()<UIActionSheetDelegate>
- (IBAction)selectBtn:(id)sender;

@end

@implementation BecomeShopUnionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
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
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self openCamera];
    }else if(buttonIndex == 1){
        [self openPhotoAlbum];
    }else{
        return;
    }
}
/*
- (void)selectPhotos:(NSMutableArray *)array
{
    [[MyAPI sharedAPI] postFilesWithFormData:array result:^(BOOL sucess, NSString *msg) {
        
        
    } errorResult:^(NSError *enginerError) {
    
    }];
    //self.photosView.imagesArray = array;
}
 */
- (IBAction)selectBtn:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从相册选取", nil];
    sheet.tag = 100;
    [sheet showInView:self.view];
}
@end

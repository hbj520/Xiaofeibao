//
//  BasePhotoViewController.m
//  CRM
//
//  Created by ebadu on 15/4/17.
//  Copyright (c) 2015年 Razi. All rights reserved.
//   121414

#import "BasePhotoViewController.h"
#import "ZYQAssetPickerController.h"

#import "FormData.h"

@interface BasePhotoViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,ZYQAssetPickerControllerDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray *_imagesArray;
    
    NSMutableArray *_imageUrls;
    
     UIImagePickerController *_picker;
}

@end

@implementation BasePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // _imagesArray = [NSMutableArray array];
    
    _imageUrls = [NSMutableArray array];
    
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
  // self.view.layer.cornerRadius
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)openPhoto{
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}

//相机选取
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self showHint:@"模拟器无法拍照"];
        return;
    }
    
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_picker animated:YES completion:nil];
}

//相册选取
- (void)openPhotoAlbum
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)selectPhotos:(NSMutableArray *)array
{
    
}

- (void)imageUrl:(NSString *)imageUrl
{
    
}

#pragma mark-UINavigationControllerDelegate & UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (self.imageBlock) {
        self.imageBlock(image);
    }
    
    NSData * data = UIImageJPEGRepresentation(image, 0.2);
    
    
   
//    UIImage *img = [UIImage imageWithData:data];
//    [_imagesArray addObject:img];
//    
//    [self selectPhotos:_imagesArray];
   
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    for (int i=0; i<assets.count; i++) {
        ALAsset *asset=assets[i];
        UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
        NSData * data = UIImageJPEGRepresentation(tempImg, 0.2);
        UIImage *img = [UIImage imageWithData:data];
        [_imagesArray addObject:img];
    }
    
    [self selectPhotos:_imagesArray];
}

- (void)uploadImageWithImages:(NSMutableArray *)images
{
    
//    [self showHudInView:self.view hint:@"上传图片..."];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);  //创建一个信号
//        
//        int i = 0;
//        for (UIImage *image in images) {
//            NSData * data = UIImageJPEGRepresentation(image, 0.1);
//            NSString *str =[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
//            str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",i++]];
//            str = [str stringByAppendingString:@".png"];
//            [data writeToFile:[Tools documentPath:str] atomically:YES];
//            [[MyAPI sharedAPI] postFileAndImage:[Tools documentPath:str] type:@"1" name:str result:^(BOOL success, NSString *msg, id object) {
//                if (success) {
//                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableContainers error:nil];
//                    NSString *url = dict[@"url"];
//                    [_imageUrls addObject:url];
//                    dispatch_semaphore_signal(semaphore);     //发送一个信号
//                }else{
//                    NSLog(@"%@",@"上传失败");
//                }
//            }];
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); //等待信号 //下载结束后继续
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self hideHud];
//        });
//        [self jointImageUrlWithImageUrls:_imageUrls];
//        
//    });
    
    
    [self showHudInView:self.view hint:@"上传图片..."];
    NSMutableArray *formDataArray = [NSMutableArray array];
    for (UIImage *image in images) {
        FormData *formData = [[FormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.000001);
        formData.name = @"file";
        formData.mimeType = @"image/jpeg";
        formData.filename = [[NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]] stringByAppendingString:@".png"];
        [formDataArray addObject:formData];
    }
    NSMutableArray *imageUrls = [NSMutableArray array];
   /*
    [[MyAPI sharedAPI] postFilesWithFormData:formDataArray result:^(BOOL sucess, NSString *msg) {
        
    } errorResult:^(NSError *enginerError) {
        
        
    }];
    */
    //    [[MyAPI sharedAPI] postFilesWithFormData:formDataArray
//                                      result:
//     ^(BOOL success, NSString *msg, id object) {
//         [self hideHud];
//         if (success) {
//             NSArray *datas = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableContainers error:nil];
//             for (NSDictionary *dict in datas) {
//                 NSString *urlStr = dict[@"url"];
//                 [imageUrls addObject:urlStr];
//             }
//             [self jointImageUrlWithImageUrls:imageUrls];
//         }else{
//             [self showHint:@"请检查网络设置"];
//         }
//     }];
}

- (void)jointImageUrlWithImageUrls:(NSMutableArray *)imageUrls
{
    NSString *imageUrl = @"";
    for (NSString *url in imageUrls) {
        if (imageUrl.length == 0) {
            imageUrl = [imageUrl stringByAppendingString:@""];
            
        }
        if (imageUrl.length != 0) {
            imageUrl = [imageUrl stringByAppendingString:@"|"];
        }
        imageUrl = [imageUrl stringByAppendingString:url];
    }
    [self imageUrl:imageUrl];
}
@end

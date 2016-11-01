//
//  MyAPI.m
//  ConsumeTreasure
//
//  Created by youyou on 11/1/16.
//  Copyright © 2016 youyou. All rights reserved.
//

#import "MyAPI.h"
#import <AFNetworking.h>
@interface MyAPI()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end
@implementation MyAPI
- (id)init{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl]] ;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}
+ (MyAPI *)sharedAPI{
    static MyAPI *sharedAPIInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAPIInstance = [[self alloc] init];
    });
    return sharedAPIInstance;
}
@end

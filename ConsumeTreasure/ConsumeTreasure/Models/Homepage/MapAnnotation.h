//
//  MapAnnotation.h
//  ConsumeTreasure
//
//  Created by youyoumacmini3 on 17/1/3.
//  Copyright © 2017年 youyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@end

//
//  LocationManager.h
//  YoLo
//
//  Created by ZWu H on 2016/11/23.
//  Copyright © 2016年 wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^CallBackLoaction)(CLPlacemark *placemark, NSError *error);

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (copy, nonatomic) CallBackLoaction callBackLoaction;

// 启动跟踪定位
- (void)startLocationAtCallBack:(CallBackLoaction)callBack;
// 根据地名确定地理坐标
- (void)getCoordinateByAddress:(NSString *)address;
// 根据坐标取得地名
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

@end

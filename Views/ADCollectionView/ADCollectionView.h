//
//  ADCollectionView.h
//  YoLo
//
//  Created by ZWu H on 2017/1/10.
//  Copyright © 2017年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ADCallBack)();

@interface ADCollectionView : UIView

- (void)showAdWithCompletion:(ADCallBack)callBack;

@end

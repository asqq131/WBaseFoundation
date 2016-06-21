//
//  ShareView.m
//  VcHappy
//
//  Created by happyvc on 16/1/4.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "ShareView.h"
#import "AppDelegate.h"

#define VIEWHEIGHT 160

@implementation ShareView
{
    UIView *_view;
    UIView *_viewBG;
    CGFloat _height;
    
}

- (id)initWithFrame:(CGRect)frame
          shareView:(NSDictionary *)shareDic
           delegate:(id<ShareViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        self.shareDic = shareDic;
        
        _viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTHYREAL, APP_HEIGHYREAL)];
        _viewBG.backgroundColor = [UIColor blackColor];
        _viewBG.alpha = 0.1;
        _viewBG.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
        [_viewBG addGestureRecognizer:tap];
        
        [self addSubview:_viewBG];
        
        NSArray *imageArray = [NSArray arrayWithObjects:@"find_icon_wechat.png",@"find_icon_circle_of_friends.png",@"find_icon_qq.png",@"find_icon_qq_zone.png",@"find_icon_micro_blog.png", nil];
        NSArray *titleArray = [NSArray arrayWithObjects:@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"新浪微博", nil];
         _height = 90*((imageArray.count/4)+1)+15;
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, APP_HEIGHYREAL, APP_WIDTHYREAL, _height)];
        _view.backgroundColor = [UIColor whiteColor];
        _view.userInteractionEnabled = YES;
        [self addSubview:_view];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            _view.frame = CGRectMake(0, APP_HEIGHYREAL-_height, APP_WIDTHYREAL, _height);
        }];
        
        
        //126 126
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _view.frame.size.width,_height)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.userInteractionEnabled = YES;
        scrollView.backgroundColor = [UIColor whiteColor];
        [_view addSubview:scrollView];
        
        for(int i=0;i<imageArray.count;i++){
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(25+((APP_WIDTHYREAL-250)/3+50)*(i%4), 15+90*(i/4), 50, 50)];
//            [btn setTitle:@"取消" forState:0];
            btn.tag = 1001+i;
            [btn setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:0];
            [btn setTitleColor:TextColor forState:0];
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = MediumFont;
            [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
            
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20+((APP_WIDTHYREAL-280)/3+60)*(i%4), 70+90*(i/4), 60, 20)];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.font = NormalFont;
            labelTitle.textAlignment = NSTextAlignmentCenter;
            labelTitle.text = [titleArray objectAtIndex:i];
            labelTitle.textColor = TextColor;
            [scrollView addSubview:labelTitle];
            
        }
        
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, _view.frame.size.height-50, _view.frame.size.width, 50)];
//        [button setTitle:@"取消" forState:0];
//        button.tag = 1001;
//        [button setTitleColor:TextColor forState:0];
//        button.backgroundColor = [UIColor clearColor];
//        button.titleLabel.font = MediumFont;
//        [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
//        [_view addSubview:button];
        
    }
    return self;
}

- (void)btnClickAction:(UIButton *)btn
{
    NSString *title = [NSString stringUtils:[self.shareDic objectForKey:@"title"]];
    NSString *content = [NSString stringUtils:[self.shareDic objectForKey:@"content"]];
    NSString *imageURL = [NSString stringUtils:[self.shareDic objectForKey:@"imageurl"]];
    NSString *url = [NSString stringUtils:[self.shareDic objectForKey:@"url"]];

    ShareType shareType;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 1001:{
            shareType = ShareTypeWeixiSession;
            break;
        }
        case 1002:{
            shareType = ShareTypeWeixiTimeline;
            break;
        }
        case 1003:{
            shareType = ShareTypeQQ;
            break;
        }
        case 1004:{
            shareType = ShareTypeQQSpace;
            break;
        }
        case 1005:{
            shareType = ShareTypeSinaWeibo;
            break;
        }
        default:
            break;
    }

     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"default_portrait" ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:title
                                                  url:url
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
//    [publishContent addQQUnitWithType:[NSNumber numberWithInteger:1] content:content title:title url:url image:[ShareSDK imageWithUrl:imageURL]];
    //    [publishContent addTencentWeiboUnitWithContent:[NSString stringWithFormat:@"%@%@",@"乐乐众筹",@"http://www.vchappy.com"] image:[ShareSDK imageWithUrl:@"http://www1.vchappy.com/public/attachment/201512/26/16/567e4a7b9da1f.jpg"]];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //弹出分享菜单
    [ShareSDK showShareViewWithType:shareType
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:nil
                       shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    
                                    
                                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"分享成功"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alertView show];
                                    DebugLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    //                                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"分享失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    //                                    [alertView show];
                                    
                                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"分享失败,错误码:%ld,错误描述:%@",(long)[error errorCode], [error errorDescription]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alertView show];
                                    
                                    //                                    MyAlertView *alt = [[MyAlertView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTHYREAL, APP_HEIGHYREAL) myAlertViewTitle:NSLocalizedString(@"prompt", @"Prompt") content:@"分享失败" delegate:nil btnArrayTitle:@[NSLocalizedString(@"ok", @"OK")]];
                                    //
                                    //                                    [self.window addSubview:alt];
                                    
                                    DebugLog([NSString stringWithFormat:@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription] ]);
                                }
                            }];
    
//    [self cancelAction];
    
    
}
- (void)cancelAction
{
    [UIView animateWithDuration:0.3 animations:^{
        _view.frame = CGRectMake(0, APP_HEIGHYREAL, APP_WIDTHYREAL, _height);
    }];
    [self performSelector:@selector(XXXX) withObject:nil afterDelay:0.3];
}
- (void)XXXX
{
    SAFERELEASE_VIEW(_viewBG);
    SAFERELEASE_VIEW(_view);
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

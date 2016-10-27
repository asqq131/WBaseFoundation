//
//  PLLAlertView.m
//  EXG_App
//
//  Created by penglingling on 15/6/15.
//  Copyright (c) 2015年 penglingling. All rights reserved.
//

#import "PLLAlertView.h"

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define iP_WIDTH [ UIScreen mainScreen ].bounds.size.width
#define iP_HEIGHT [ UIScreen mainScreen ].bounds.size.height

static CGFloat const titleFontSize = 17.0f;
static CGFloat const messageFontSize = 14.0f;
static CGFloat const buttonTitleFontSize = 16.0f;
static CGFloat const leadingMargins = 30.0f;
static CGFloat const imageWidth = 51.0f;
static CGFloat const buttonHeight = 37.0f;

@interface PLLAlertView (){
    CGFloat _contentViewHeight;
    CGRect _titleRect;
    CGRect _messageRect;
    CGFloat _totalHeightForButtons;
    CGFloat _buttonScale;
}

@property (copy, nonatomic) PLLAlertViewCallback callback;
@property (weak, nonatomic) UIView *superView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *message;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation PLLAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString*)message
               buttonTitleArr:(NSArray*)buttonTitleArr
                  atSuperView:(UIView*)atSuperView
                       status:(PLLAlertViewStatus)status
                     maskType:(PLLAlertViewMaskType)maskType
                     callback:(PLLAlertViewCallback)callback;
{
    self = [super init];
    if (self) {
        [self setupWithTitle:title
                     message:message
              buttonTitleArr:buttonTitleArr
                 atSuperView:atSuperView
                      status:status
                    maskType:maskType
                    callback:callback];
    }
    return self;
}

- (void)setupWithTitle:(NSString *)title
               message:(NSString*)message
        buttonTitleArr:(NSArray*)buttonTitleArr
           atSuperView:(UIView*)atSuperView
                status:(PLLAlertViewStatus)status
              maskType:(PLLAlertViewMaskType)maskType
              callback:(PLLAlertViewCallback)callback;

{
    //按钮比例
    _buttonScale = iP_HEIGHT > 568.0f ? iP_HEIGHT / 568.0f : 1.0f;

    //设置回调
    self.callback = callback;
    
    //设置背景
    [self setupBackgroundWithMasktype:maskType atSuperView:atSuperView];
    
    //计算contentView视图的高度
    _contentViewHeight = [self calculateContentViewHeightWithTitle:title
                                                           message:message
                                                    buttonTitleArr:buttonTitleArr];
    
    //标题
    self.title.text = title;
    
    //内容
    self.message.text = message;
    
    //图片
    switch (status) {
        case PLLAlertViewStatusSuccess:
        {
            self.imageView.image = [UIImage imageNamed:kResourceSrcName(@"su_ic_success")];
        }
            break;
            
        case PLLAlertViewStatusNormal:
        {
            self.imageView.image = [UIImage imageNamed:kResourceSrcName(@"icon_warning")];
        }
            break;
            
        case PLLAlertViewStatusError:
        {
            self.imageView.image = [UIImage imageNamed:kResourceSrcName(@"icon_error")];
        }
            break;
            
        default:
            break;
    }
    
    //设置按钮
    [self createButtonsWitButtonTitleArr:buttonTitleArr];
    
    //设置约束
    [self addSubViewsConstraints];
}

- (void)setupBackgroundWithMasktype:(PLLAlertViewMaskType)maskType
                        atSuperView:(UIView*)atSuperView
{
    
    self.frame = CGRectMake(0.0f, 0.0f, iP_WIDTH, iP_HEIGHT);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    self.superView = atSuperView;
    self.alpha = 0.0f;
    self.hidden = YES;
    
    if (maskType == PLLAlertViewMaskTypeAllowUIEnabled) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
    }else{
        
    }
}

- (void)setupContentViewWithTitle:(NSString*)title
                          message:(NSString*)message
                   buttonTitleArr:(NSArray*)buttonTitleArr
                           status:(PLLAlertViewStatus)status
{
    
    
}

- (void)createButtonsWitButtonTitleArr:(NSArray*)array
{
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *title = (NSString*)obj;
        
        if (array.count == 2) {
            
            BOOL needLeftLine = idx == 0 ? NO : YES;
//            UIColor *textColor = [title isEqualToString:@"我要优惠劵"] ? RGB(255.0f, 144.0f, 0.0f) : nil;
            UIColor *textColor = nil;
            
            UIButton *button = [self alertViewButtonWithTitle:title
                                                          idx:idx + 1
                                                  needTopLine:YES
                                                 needLeftLine:needLeftLine
                                                    textColor:textColor];
            
            CGFloat width = (iP_WIDTH - 2 * leadingMargins) / 2.0f;
            
            //添加约束
            NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(button);
            NSDictionary *metrics = @{@"buttonHeight":@(buttonHeight * _buttonScale),
                                      @"topDistance":@(0),
                                      @"leadingDistance":@(idx * width),
                                      @"width":@(width)};
            
            [self.buttonView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leadingDistance-[button(width)]"
                                                     options:0
                                                     metrics:metrics
                                                       views:viewsDictionary]];
            
            [self.buttonView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topDistance-[button(buttonHeight)]"
                                                     options:0
                                                     metrics:metrics
                                                       views:viewsDictionary]];
            
            
        }else{
            
            UIButton *button = [self alertViewButtonWithTitle:title
                                                          idx:idx + 1
                                                  needTopLine:YES
                                                 needLeftLine:NO
                                                    textColor:nil];
            //添加约束
            NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(button);
            NSDictionary *metrics = @{@"buttonHeight":@(buttonHeight * _buttonScale),
                                      @"topDistance":@(idx * buttonHeight * _buttonScale)};
            
            [self.buttonView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[button]-0-|"
                                                     options:0
                                                     metrics:metrics
                                                       views:viewsDictionary]];
            
            [self.buttonView addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topDistance-[button(buttonHeight)]"
                                                     options:0
                                                     metrics:metrics
                                                       views:viewsDictionary]];
        }
    }];
    
}

- (UIButton*)alertViewButtonWithTitle:(NSString*)title
                                  idx:(NSInteger)idx
                          needTopLine:(BOOL)needTopLine
                         needLeftLine:(BOOL)needLeftLine
                            textColor:(UIColor*)textColor

{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:buttonTitleFontSize];
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:RGB(102.0f, 102.0f, 102.0f) forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.tag = idx;
    [button addTarget:self action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:button];
    
    if (needTopLine) {
        UIView *line = [UIView new];
        line.backgroundColor = RGB(232.0f, 232.0f, 232.0f);
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [button addSubview:line];
        
        //添加约束
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(line);
        
        [button addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[line]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [button addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[line(1)]"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
    }
    
    if (needLeftLine) {
        UIView *line = [UIView new];
        line.backgroundColor = RGB(232.0f, 232.0f, 232.0f);
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [button addSubview:line];
        
        //添加约束
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(line);
        
        [button addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[line(1)]"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
        [button addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[line]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:viewsDictionary]];
        
    }
    
    
    return button;
}

- (void)addSubViewsConstraints
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    //添加约束
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_contentView,
                                                                   _imageView,
                                                                   _title,
                                                                   _message,
                                                                   _buttonView);
    
    NSDictionary *metrics = @{@"contentViewHeight":@(_contentViewHeight),
                              @"leadingMargins":@(leadingMargins),
                              @"imageWidht":@(imageWidth),
                              @"titleWidth":@(_titleRect.size.width),
                              @"titleHeight":@(_titleRect.size.height),
                              @"messageWidth":@(_messageRect.size.width),
                              @"messageHeight":@(_messageRect.size.height),
                              @"totalHeightForButtons":@(_totalHeightForButtons)};
    
    //contentView的约束
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leadingMargins-[_contentView]-leadingMargins-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_contentView(contentViewHeight)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    
    /*子视图横向约束*/
    
    //图片
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView(imageWidht)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    //标题
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_title
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=10-[_title]->=10-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    //内容
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=10-[_message(messageWidth)]->=10-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_message
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    //按钮父视图
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_buttonView]-0-|"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    //竖向约束
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(14)-[_imageView(imageWidht)]-9-[_title(titleHeight)]-15-[_message(messageHeight)]-15-[_buttonView(totalHeightForButtons)]"
                                             options:0
                                             metrics:metrics
                                               views:viewsDictionary]];
    
    
    
    
    [self layoutIfNeeded];
}

#pragma mark Selector
- (void)buttonAction:(UIButton*)sender
{
    if (self.callback) {
        self.callback(sender.tag);
    }
    [self dismiss];
}

- (void)show
{
    [self.superView addSubview:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    //清除block
    self.callback = nil;
    //消失
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark calculateHeight

- (CGFloat)calculateContentViewHeightWithTitle:(NSString*)title
                                       message:(NSString*)message
                                buttonTitleArr:(NSArray*)buttonTitleArr
{
    
    //计算message,title的空间
    _titleRect = [self calculateRectByText:title
                                      font:[UIFont systemFontOfSize:titleFontSize]
                                      size:CGSizeMake(iP_WIDTH - leadingMargins * 4, iP_HEIGHT / 4.0f)];
    
    _messageRect = [self calculateRectByText:message
                                        font:[UIFont systemFontOfSize:messageFontSize]
                                        size:CGSizeMake(iP_WIDTH - (leadingMargins * 2 + 20.0f), iP_HEIGHT / 2.0f)];
    
    //计算高度
    _totalHeightForButtons = 0.0f;
    if (buttonTitleArr && buttonTitleArr.count != 0) {
        _totalHeightForButtons = buttonTitleArr.count == 2 ? buttonHeight * _buttonScale : buttonHeight * _buttonScale * buttonTitleArr.count;
    }
    
    CGFloat contentViewHeight = 14.0f + imageWidth + 9.0f + (_titleRect.size.height) + 15.0f + (_messageRect.size.height) + 15.0f + _totalHeightForButtons;
    
    return contentViewHeight;
}


- (CGRect)calculateRectByText:(NSString*)text
                         font:(UIFont*)font
                         size:(CGSize)size
{
    CGRect newRect;
    CGSize newsize = [text boundingRectWithSize:size
                                        options:NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    newRect = CGRectMake(0.0f, 0.0f, ceil(newsize.width), ceil(newsize.height));
    
    return  newRect;
}

#pragma mark GetterSetter
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.layer.cornerRadius =  0.15 * (iP_WIDTH - leadingMargins * 2) / 4.0f;
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel*)title
{
    if (!_title) {
        _title = [UILabel new];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
        _title.font = [UIFont systemFontOfSize:titleFontSize];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = RGB(255.0f, 114.0f, 0.0f);
        _title.numberOfLines = 0;
        [self.contentView addSubview:_title];
    }
    return _title;
}

- (UILabel*)message
{
    if (!_message) {
        _message = [UILabel new];
        _message.translatesAutoresizingMaskIntoConstraints = NO;
        _message.font = [UIFont systemFontOfSize:messageFontSize];
        _message.backgroundColor = [UIColor clearColor];
        _message.textColor = RGB(102.0f, 102.0f, 102.0f);
        _message.numberOfLines = 0;
        [self.contentView addSubview:_message];
    }
    return _message;
}

- (UIView*)buttonView
{
    if (!_buttonView) {
        _buttonView = [UIView new];
        _buttonView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_buttonView];
    }
    return _buttonView;
}

#pragma mark dealloc
- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}


@end

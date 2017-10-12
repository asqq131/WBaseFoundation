# WBaseFoundation
iOS W标识自建框架

1.引导图view使用

``- (void)checkFirstLoad {`
    
    __weak __typeof(self)weakSelf = self;
    void(^showAd)() = ^() {
        weakSelf.adCollectionView = [[ADCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        [weakSelf.view addSubview:self.adCollectionView];
        
        [self.adCollectionView showAdWithCompletion:^{
            [UIView animateWithDuration:0.3 animations:^{
                [weakSelf.adCollectionView removeFromSuperview];
                weakSelf.adCollectionView = nil;
            } completion:nil];
        }];
    };
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL firstLoad = [userDefaults boolForKey:kIsNotFirstLoad];
    if (!firstLoad) {
        [userDefaults setBool:YES forKey:kIsNotFirstLoad];
        showAd();
        
    } else if (version != [userDefaults valueForKey:kAppVersion]) { // 更新了版本显示引导图
        //        showAd();
    }
    
    [userDefaults setValue:version forKey:kAppVersion];}`


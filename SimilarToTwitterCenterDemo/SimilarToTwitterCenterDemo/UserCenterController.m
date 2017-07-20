//
//  UserCenterController.m
//  SimilarToTwitterCenterDemo
//
//  Created by smok on 2017/5/4.
//  Copyright © 2017年 IVPS. All rights reserved.
//

#import "UserCenterController.h"
#import "UserHeaderView.h"
#import "UIImage+XYBlurView.h"
#import "Masonry.h"

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kHeaderViewHeight  263 // The height of Header
#define kHeadImageHeight   160 //The height of the ImageView of the header
#define kNavHeight         64  //The ImageView stays at the top of the height
#define kLabelOffset       (kHeadImageHeight-kNavHeight+45)// At this offset the Black label reaches the Header
#define kLabelDistance    35// The distance that the white label moves

@interface UserCenterController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UserHeaderView *headerView;
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) UIView       *navView;
@property (nonatomic, strong) UILabel      *userNameLabel;
@property (nonatomic, strong) UIImageView  *navImageView;
@property (nonatomic, strong) UIImageView  *navBlurImageView;
@end

@implementation UserCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)initSubViews {
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight);
    self.tableView.tableHeaderView = self.headerView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.navView];
    self.tableView.frame = self.view.bounds;
    //navImageView
    self.navImageView = [[UIImageView alloc] initWithFrame:self.navView.bounds];
    self.navImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.navImageView.clipsToBounds = YES;
     self.navImageView.image = [UIImage imageNamed:@"default_background"];
    [self.navView addSubview:self.navImageView];
    
    self.navBlurImageView = [[UIImageView alloc] initWithFrame:self.navView.bounds];
    self.navBlurImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.navBlurImageView.clipsToBounds = YES;
    [self.navView addSubview:self.navBlurImageView];
    self.navBlurImageView.image = [[UIImage imageNamed:@"default_background"] blurredImageWithRadius:20 iterations:20 tintColor:[UIColor clearColor]];
    
    //name label
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.font = [UIFont systemFontOfSize:20];
    self.userNameLabel.text = @"Elina";
    self.userNameLabel.textColor = [UIColor whiteColor];
    [self.navView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(0);
        make.width.mas_equalTo(200);
        make.centerX.equalTo(self.navView);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CATransform3D avatarTransform = CATransform3DIdentity;
    if (offset < 0 ) {
        [self.headerView layoutSubViewWhenScroll:offset];
    } else {
        // Avatar -----------
        CGFloat avHeight = self.headerView.avatarImageView.bounds.size.height;
        CGFloat avatarScaleFactor = (MIN(kHeadImageHeight-kNavHeight, offset))/(kHeadImageHeight-kNavHeight)*0.5;
        CGFloat avatarSizeVariation = (avHeight*avatarScaleFactor)/2.0;
        avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0);
        avatarTransform = CATransform3DScale(avatarTransform, 1.0-avatarScaleFactor, 1.0 - avatarScaleFactor,0);
        
        //  ------------ Label
        CATransform3D labelTransform = CATransform3DMakeTranslation(0, MAX(-kLabelDistance, kLabelOffset - offset), 0);
        self.userNameLabel.layer.transform = labelTransform;
        
        //  ------------ Blur
        self.navBlurImageView.alpha = MIN (1.0, (offset - kLabelOffset)/kLabelDistance);
        
    }
    self.headerView.avatarImageView.layer.transform = avatarTransform;
    
    if (offset > kHeadImageHeight-kNavHeight) {
        self.navView.alpha = 1;
    } else {
        self.navView.alpha = 0;
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

#pragma mark - setter && getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init ];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UserHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserHeaderView" owner:self options:nil] firstObject];
    }
    return _headerView;
}

- (UIView *)navView {
    if (_navView == nil) {
        _navView = [[UIView alloc] init];
        _navView.frame = CGRectMake(0, kNavHeight-kHeadImageHeight, kScreenWidth, kHeadImageHeight);
        _navView.alpha = 0;
        _navView.clipsToBounds = YES;
        _navView.backgroundColor = [UIColor blueColor];
    }
    return _navView;
}
@end

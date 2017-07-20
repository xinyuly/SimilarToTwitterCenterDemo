//
//  MeHeaderView.h
//  testHome
//
//  Created by smok on 2017/5/3.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel  *userNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *followingBtn;

@property (weak, nonatomic) IBOutlet UIButton *followersBtn;

- (void)layoutSubViewWhenScroll:(CGFloat) offsetY;

@end

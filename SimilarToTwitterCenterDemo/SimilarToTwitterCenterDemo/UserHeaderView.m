//
//  MeHeaderView.m
//  testHome
//
//  Created by smok on 2017/5/3.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import "UserHeaderView.h"

@implementation UserHeaderView

- (void)layoutSubViewWhenScroll:(CGFloat) offsetY {
    
    CGRect rect = CGRectMake(0, 0, self.bgImgView.bounds.size.width, 160);
    rect.origin.y += offsetY;
    rect.size.height -= offsetY;
    self.bgImgView.frame = rect;
}

@end

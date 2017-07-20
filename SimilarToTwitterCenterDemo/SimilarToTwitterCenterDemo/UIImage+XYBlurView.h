//
//  UIImage+XYBlurView.h
//  SimilarToTwitterCenterDemo
//
//  Created by smok on 2017/5/4.
//  Copyright © 2017年 IVPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYBlurView)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end

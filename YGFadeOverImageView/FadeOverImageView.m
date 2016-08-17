//
//  FadeOverImageView.m
//  Test11FadeOverImageView
//
//  Created by Jason Yang on 16/8/17.
//  Copyright © 2016年 YG. All rights reserved.
//

#import "FadeOverImageView.h"

@interface FadeOverImageView_Animation : CABasicAnimation
@property (nonatomic, weak) CALayer *layer;
@end

@implementation FadeOverImageView_Animation

- (instancetype)copyWithZone:(NSZone *)zone {
    FadeOverImageView_Animation *copy = [super copyWithZone:zone];
    copy.layer = self.layer;
    return copy;
}

@end

@implementation FadeOverImageView

- (void)setImage:(UIImage *)image {
    UIImageView *fadeView = [[UIImageView alloc] initWithImage:self.image];
    fadeView.alpha = 0;
    fadeView.frame = self.bounds;
    fadeView.contentMode = self.contentMode;
    fadeView.backgroundColor = self.backgroundColor;
    CALayer *fadeLayer = fadeView.layer;
    
    [super setImage:image];
    [self.layer insertSublayer:fadeLayer atIndex:0];
    
    FadeOverImageView_Animation *animation = [FadeOverImageView_Animation animationWithKeyPath:@"opacity"];
    animation.layer = fadeLayer;
    animation.delegate = self;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    if (self.duration > 0) {
        animation.duration = self.duration;
    }
    
    [fadeLayer addAnimation:animation forKey:@"fade-out"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
    if ([animation isKindOfClass:FadeOverImageView_Animation.class]) {
        [((FadeOverImageView_Animation *)animation).layer removeFromSuperlayer];
    }
}

@end

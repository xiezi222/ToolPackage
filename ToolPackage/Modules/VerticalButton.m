//
//  VerticalButton.m
//  ToolPackage
//
//  Created by xing on 2020/7/6.
//  Copyright © 2020 xing. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(CGRectGetHeight(self.imageView.bounds),
                                               -CGRectGetWidth(self.imageView.bounds),
                                               0,
                                               0);
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(-CGRectGetHeight(self.titleLabel.bounds),
                                               0,
                                               0,
                                               -CGRectGetWidth(self.titleLabel.bounds));
    if (self.imageView.image && self.titleLabel.text.length) {
        titleInsets.top = titleInsets.top + _interval / 2.0;
        imageInsets.bottom = imageInsets.bottom + _interval / 2.0;
    }
    
    
    
    CGFloat width = MAX(CGRectGetWidth(self.titleLabel.bounds), CGRectGetWidth(self.imageView.bounds));
    width = width + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    CGFloat height = CGRectGetHeight(self.titleLabel.bounds) + CGRectGetHeight(self.imageView.bounds);
    height = height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom + _interval;
    
    self.titleEdgeInsets = titleInsets;
    self.imageEdgeInsets = imageInsets;
    CGFloat x = self.center.x - width / 2.0;
    CGFloat y = self.center.y - height / 2.0;
    self.frame = CGRectMake(x, y, width, height);
}


@end

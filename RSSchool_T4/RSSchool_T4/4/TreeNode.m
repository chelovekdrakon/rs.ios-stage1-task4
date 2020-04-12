//
//  TreeNode.m
//  RSSchool_T4
//
//  Created by Фёдор Морев on 4/11/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = @(0);
        _left = [NSNull null];
        _right = [NSNull null];
    }
    return self;
}

@end

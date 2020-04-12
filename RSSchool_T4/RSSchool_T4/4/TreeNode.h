//
//  TreeNode.h
//  RSSchool_T4
//
//  Created by Фёдор Морев on 4/11/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject
@property(retain, nonatomic)TreeNode *right;
@property(retain, nonatomic)TreeNode *left;
@property(retain, nonatomic)NSNumber *value;
@end

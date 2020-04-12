#import "FullBinaryTrees.h"
#import "TreeNode.h"

@implementation FullBinaryTrees : NSObject

- (NSArray *)getAllPossibleFBT:(NSInteger)count {
    NSMutableArray *resultArr = [NSMutableArray new];
    
    if (count == 1) {
        TreeNode *node = [TreeNode new];
        [resultArr addObject:node];
    } else if (count % 2 == 1) {
        for (int x = 0; x < count; x++) {
            NSArray *leftTree = [self getAllPossibleFBT:x];
            
            for (TreeNode *leftNode in leftTree) {
                NSArray *rightTree = [self getAllPossibleFBT:count - x - 1];
                
                for (TreeNode *rightNode in rightTree) {
                    TreeNode *rootNode = [TreeNode new];
                    
                    [rootNode setValue:leftNode forKey:@"left"];
                    [rootNode setValue:rightNode forKey:@"right"];
                    
                    [resultArr addObject:rootNode];
                }
            }
        }
    }
        
    return resultArr;
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    NSArray *resultArr = [self getAllPossibleFBT:count];
    NSString *result = [self parseArrayOfBST:resultArr];
    
    return result;
}

- (NSString *)parseArrayOfBST:(NSArray *)array {
    NSMutableArray *arr = [NSMutableArray new];
    
    for (TreeNode *node in array) {
        NSMutableArray<NSMutableArray *> *resArr = [NSMutableArray array];
        [self printNode:node onLevel:0 toArray:resArr];
        
        NSMutableArray *res = [NSMutableArray array];
        
        for (NSMutableArray *levelArr in resArr) {
            for (int i = 0; i < ceil((float)levelArr.count / 4); i++) {
                int from = i * 4;
                int to = (i + 1) * 4;
                NSRange range = NSMakeRange(from, to > levelArr.count ? levelArr.count - from : 4);
                NSArray *filterArr = [levelArr subarrayWithRange:range];
                
                NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self isEqual: %@", @"0"];
                NSArray *nodesArray = [filterArr filteredArrayUsingPredicate:predicate];
                
                if (nodesArray.count > 0) {
                    NSString *levelStr = [levelArr componentsJoinedByString:@","];
                    [res addObject:levelStr];
                }
            }
        }
        
        NSArray *bstWithTrailingNulls = [[res componentsJoinedByString:@","] componentsSeparatedByString:@","];
        NSArray *bst = [self removeTrailingNulls:bstWithTrailingNulls];
        
        [arr addObject:[NSString stringWithFormat:@"[%@]", [bst componentsJoinedByString:@","]]];
    }
         
    NSString *res = [NSString stringWithFormat:@"[%@]", [arr componentsJoinedByString:@","]];
    
    return res;
}

- (NSArray *)removeTrailingNulls:(NSArray<NSArray *> *)bst {
    NSMutableArray *bstCopy = [bst mutableCopy];
        
    BOOL isHeadCleaned = NO;
    
    while(!isHeadCleaned) {
        NSString *node = bstCopy[0];
        
        if ([node isEqualToString:@"null"]) {
            [bstCopy removeObjectAtIndex:0];
        } else {
            isHeadCleaned = YES;
        }
    }
    
    BOOL isEndCleaned = NO;
    
    while(!isEndCleaned) {
        NSUInteger lastIndex = bstCopy.count - 1;
        NSString *node = bstCopy[lastIndex];
        
        if ([node isEqualToString:@"null"]) {
            [bstCopy removeObjectAtIndex:lastIndex];
        } else {
            isEndCleaned = YES;
        }
    }
    
    return bstCopy;
}

- (void)printNode:(TreeNode *)node onLevel:(int)treeLevel toArray:(NSMutableArray<NSMutableArray *> *)array {
    while (array.count <= treeLevel) {
        [array addObject:[NSMutableArray array]];
    }
    
    NSMutableArray *levelArray = array[treeLevel];
    
    if ([node isKindOfClass:[TreeNode class]]) {
        [levelArray addObject:@"0"];
        [self printNode:node.left onLevel:(treeLevel + 1) toArray:array];
        [self printNode:node.right onLevel:(treeLevel + 1) toArray:array];
    } else {
        [levelArray addObject:@"null"];
    }
}

@end

#import "SquareDecomposer.h"

@implementation SquareDecomposer

- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    NSNumber *n = [NSNumber numberWithLongLong:[number longLongValue]];
    NSNumber *remain = [NSNumber numberWithLongLong:[number longLongValue] * [number longLongValue]];
    
    NSMutableArray *decomposeArray = [self decomposer:n remain:remain];
    
    if (decomposeArray == nil) {
        return nil;
    } else {
        [decomposeArray removeLastObject];
        return decomposeArray;
    }
}

- (NSMutableArray *)decomposer:(NSNumber *)n remain:(NSNumber *)remain {
    if ([remain longLongValue] == 0) {
        return [NSMutableArray arrayWithObject:n];
    }
    
    for(long long i = [n longLongValue] - 1; i > 0; i--) {
        long long iSquare = i * i;
        
        if(([remain longLongValue] - iSquare) >= 0){
            NSNumber *nextN = [NSNumber numberWithLongLong:i];
            NSNumber *nextRemain = [NSNumber numberWithLongLong:([remain longLongValue] - iSquare)];
            
            NSMutableArray *r = [self decomposer:nextN remain:nextRemain];
            
            if (r != nil){
                [r addObject:n];
                return r;
            }
        }
    }
    
    return nil;
}

@end

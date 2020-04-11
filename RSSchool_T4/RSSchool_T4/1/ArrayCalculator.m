#import "ArrayCalculator.h"

@implementation ArrayCalculator

+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@", [NSNumber class]];
    NSArray *numbersArray = [array filteredArrayUsingPredicate:predicate];
    
    if (numberOfItems == 0 || numbersArray.count == 0) {
        return 0;
    }
    
    if (numberOfItems >= numbersArray.count) {
        return [ArrayCalculator getProductOfNumbersArray:numbersArray];
    }
    
    NSMutableArray *positiveNumbers = [NSMutableArray array];
    NSMutableArray *negativeNumbers = [NSMutableArray array];
    
    for (NSNumber *num in numbersArray) {
        if ([num intValue] < 0) {
            [negativeNumbers addObject:num];
        } else {
            [positiveNumbers addObject:num];
        }
    }
    
    NSArray *positiveNumberDescending = [[[positiveNumbers sortedArrayUsingSelector:@selector(compare:)] reverseObjectEnumerator] allObjects];
    NSArray *highestPositiveNumbersDescending = [positiveNumberDescending subarrayWithRange:NSMakeRange(0, numberOfItems > positiveNumbers.count ?  positiveNumbers.count : numberOfItems)];
    
    NSMutableArray *numbersToMultiply = [[[highestPositiveNumbersDescending reverseObjectEnumerator] allObjects] mutableCopy];

    if (negativeNumbers.count > 1) {
        NSMutableArray *negativeNumbersDescending = [[negativeNumbers sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
        
        for (int i = 0; i < (negativeNumbersDescending.count / 2); i++) {
            NSNumber *firstNegative = negativeNumbersDescending[i];
            NSNumber *secondNegative = negativeNumbersDescending[i + 1];
            
            NSNumber *firstPositive = numbersToMultiply[i];
            NSNumber *secondPositive = numbersToMultiply[i + 1];
            
            int positiveProduct = [firstPositive intValue] * [secondPositive intValue];
            int negativeProduct = [firstNegative intValue] * [secondNegative intValue];
            
            if (negativeProduct > positiveProduct) {
                [numbersToMultiply replaceObjectAtIndex:i withObject:firstNegative];
                [numbersToMultiply replaceObjectAtIndex:(i + 1) withObject:secondNegative];
            }
        }
    }
    
    return [ArrayCalculator getProductOfNumbersArray:numbersToMultiply];
}

+ (NSInteger)getProductOfNumbersArray:(NSArray *)array {
    NSInteger res = 1;
    
    for (NSObject *obj in array) {
        NSNumber *num = (NSNumber *)obj;
        res *= [num intValue];
    }
    
    return res;
}

@end

#import "TelephoneFinder.h"

@interface TelephoneFinder()
@property(nonatomic, strong) NSDictionary<NSString *, NSArray *> *mapDigitToneighbors;
@end

@implementation TelephoneFinder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mapDigitToneighbors = @{
            @"0": @[@"8"],
            @"1": @[@"2", @"4"],
            @"2": @[@"1", @"3", @"5"],
            @"3": @[@"2", @"6"],
            @"4": @[@"1", @"5", @"7"],
            @"5": @[@"2", @"4", @"6", @"8"],
            @"6": @[@"3", @"5", @"9"],
            @"7": @[@"4", @"8"],
            @"8": @[@"0", @"5", @"7", @"9"],
            @"9": @[@"6", @"8"],
        };
    }
    return self;
}

- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    if (number.length < 1 || number.length > 9 || [number intValue] < 0) {
        return nil;
    }

    NSMutableArray *result = [NSMutableArray array];
    
    for (int i = 0; i < number.length; i++) {
        NSString *digit = [number substringWithRange:NSMakeRange(i, 1)];
        
        NSArray *digitNeighbors = [self.mapDigitToneighbors objectForKey:digit];
        
        for (NSString *digitNeighbor in digitNeighbors) {
            NSString *neighborNumber = [number stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:digitNeighbor];
            [result addObject:neighborNumber];
        }
    }
    
    return result;
}
@end

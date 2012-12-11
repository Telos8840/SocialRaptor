#import <Foundation/Foundation.h>
#import "TableTab1.h"

@interface DataLoader : NSObject

@property (strong, nonatomic) TableTab1 *delegate;
- (void)loadData;

@end
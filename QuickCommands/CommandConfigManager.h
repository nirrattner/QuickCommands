#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommandConfigManager : NSObject

- (NSArray *)loadConfig;
- (void)editConfig;

@end

NS_ASSUME_NONNULL_END

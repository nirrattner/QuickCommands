#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class AppDelegate;

@interface CommandTextFieldController : NSViewController <NSTextFieldDelegate>

@property (weak) AppDelegate *appDelegate;
@property (weak) NSArray *commandConfigs;

@end

NS_ASSUME_NONNULL_END

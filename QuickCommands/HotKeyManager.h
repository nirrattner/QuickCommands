#import <Carbon/Carbon.h>

@interface HotKeyManager : NSObject {
  EventHotKeyRef eventHotKeyRef;
}

- (id)initWithTarget:(id)target selector:(SEL)selector;
- (void)invoke;

@end

#import "HotKeyManager.h"

@interface HotKeyManager ()

@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;

@end

static OSStatus handleHotKey(EventHandlerCallRef nextHandler, EventRef event, void * data) {  
  HotKeyManager * hotKeyManager = (__bridge HotKeyManager *) data;
  [hotKeyManager invoke];
  return noErr;
}

@implementation HotKeyManager

- (id)initWithTarget:(id)target selector:(SEL)selector {
  if (self = [super init]) {
    self.target = target;
    self.selector = selector;
    
    EventHotKeyID hotKeyId;
    hotKeyId.id = 0;
    hotKeyId.signature = 'hkid';
    EventTypeSpec eventType;
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    
    InstallApplicationEventHandler(&handleHotKey, 1, &eventType, (__bridge void *) self, NULL);
    RegisterEventHotKey(kVK_Space, optionKey, hotKeyId, GetApplicationEventTarget(), 0, &eventHotKeyRef);
  }
  return self;
}

- (void)invoke {
  IMP imp = [self.target methodForSelector:self.selector];
  void (*func)(id, SEL) = (void *) imp;
  func(self.target, self.selector);
}

- (void)dealloc {
  UnregisterEventHotKey(eventHotKeyRef);
}

@end

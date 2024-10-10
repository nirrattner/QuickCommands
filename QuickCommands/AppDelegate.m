#import "AppDelegate.h"
#import "CommandConfigManager.h"
#import "CommandTextField.h"
#import "CommandTextFieldController.h"
#import "HotKeyManager.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet CommandTextField *commandTextField;
@property (nonatomic, strong) CommandConfigManager *commandConfigManager;
@property (nonatomic, strong) HotKeyManager *hotKeyManager;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSArray *commandConfigs;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [self initializeMenu];
  self.commandConfigManager = [[CommandConfigManager alloc] init];
  self.hotKeyManager = [[HotKeyManager alloc] initWithTarget:self selector:@selector(showWindow)];
  ((CommandTextFieldController *) self.commandTextField.delegate).appDelegate = self;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void)initializeMenu {
  NSMenu * menu = [[NSMenu alloc] init];
  [menu addItemWithTitle:@"Config" action:@selector(editConfig) keyEquivalent:@""];
  [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
  
  self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  self.statusItem.button.title = @"";
  self.statusItem.button.image = [NSImage imageNamed:@"terminal-icon"];
  self.statusItem.menu = menu;
}

- (void)showWindow {
  [self.window setCollectionBehavior:NSWindowCollectionBehaviorMoveToActiveSpace];
  [self.window makeKeyAndOrderFront:nil];
  [self.window orderFrontRegardless];
  [self.window center];
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
  
  [self.commandTextField becomeFirstResponder];
  self.commandTextField.stringValue = @"";
  
  self.commandConfigs = [self.commandConfigManager loadConfig];
  ((CommandTextFieldController *) self.commandTextField.delegate).commandConfigs = self.commandConfigs;
}

- (void)editConfig {
  [self.commandConfigManager editConfig];
}

- (void)didEscapeKeyDown {
  self.window.isVisible = NO;
  [[NSApplication sharedApplication] hide:nil];
}

- (void)didEnterKeyDown {
  self.window.isVisible = NO;
  [[NSApplication sharedApplication] hide:nil];
  
  for (NSDictionary *commandConfig in self.commandConfigs) {
    NSString *key = commandConfig[@"key"];
    if ([key hasPrefix:self.commandTextField.stringValue]) {
      system([commandConfig[@"command"] UTF8String]);
      /*
      NSArray *commandSections = [commandConfig[@"command"] componentsSeparatedByString: @" "];
      NSTask *task = [[NSTask alloc] init];
      task.launchPath = [commandSections objectAtIndex:0];
      task.arguments = [commandSections subarrayWithRange:NSMakeRange(1, commandSections.count - 1)];
      [task launch];
        */
    }
  }
  // TODO: Execute command
}

@end

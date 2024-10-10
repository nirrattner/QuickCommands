#import <Carbon/Carbon.h>
#import "AppDelegate.h"
#import "CommandTextField.h"
#import "CommandTextFieldController.h"

@interface CommandTextFieldController ()

@property (weak) IBOutlet CommandTextField *commandTextField;
@property (nonatomic) BOOL isCompleting;
@property (nonatomic) BOOL isLastDelete;

@end

@implementation CommandTextFieldController

- (BOOL)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector {
  if (commandSelector == @selector(insertNewline:)) {
    [self.appDelegate didEnterKeyDown];
    return YES;
  } else if (commandSelector == @selector(cancelOperation:)) {
    [self.appDelegate didEscapeKeyDown];
    return YES;
  } else if (commandSelector == @selector(deleteBackward:)
      || commandSelector == @selector(deleteForward:)) {
    self.isLastDelete = YES;
    return NO;
  }
  return NO;
}

- (void)controlTextDidChange:(NSNotification *)notification {
  if (!self.isCompleting) {
    self.isCompleting = YES;
    if (self.isLastDelete) {
      self.isLastDelete = NO;
    } else {
      NSTextField *textField = [notification object];
      NSTextView *textView = [[notification userInfo] objectForKey:@"NSFieldEditor"];
      
      NSMutableArray *autocompleteValues = [[NSMutableArray alloc] initWithCapacity:[self.commandConfigs count]];
      for (NSDictionary *commandConfig in self.commandConfigs) {
        NSString *key = commandConfig[@"key"];
        if ([key hasPrefix:self.commandTextField.stringValue]) {
          [autocompleteValues addObject:key];
        }
      }
      
      if (autocompleteValues.count >= 1) {
        NSString *completion = [autocompleteValues objectAtIndex:0];
        NSRange difference = NSMakeRange(textField.stringValue.length, completion.length - textField.stringValue.length);
        textView.string = completion;
        [textView setSelectedRange:difference
            affinity:NSSelectionAffinityUpstream
            stillSelecting:NO];
      }
    }
    self.isCompleting = NO;
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.isCompleting = NO;
  self.isLastDelete = NO;
}

@end

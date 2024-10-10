#import "CommandWindow.h"

@implementation CommandWindow

- (BOOL)canBecomeKeyWindow {
  return YES;
}

- (BOOL)performKeyEquivalent:(NSEvent *)event {;
  if (event.type == NSEventTypeKeyDown
      && (event.modifierFlags & NSEventModifierFlagCommand) == NSEventModifierFlagCommand
      && (event.modifierFlags & NSEventModifierFlagOption) == 0
      && (event.modifierFlags & NSEventModifierFlagShift) == 0
      && (event.modifierFlags & NSEventModifierFlagControl) == 0) {
    if ([event.charactersIgnoringModifiers isEqualToString:@"a"]
        && [[NSApplication sharedApplication] sendAction:@selector(selectAll:) to:nil from:self]) {
      return YES;
    }
    if ([event.charactersIgnoringModifiers isEqualToString:@"c"]
        && [[NSApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self]) {
      return YES;
    }
    if ([event.charactersIgnoringModifiers isEqualToString:@"v"]
        && [[NSApplication sharedApplication] sendAction:@selector(paste:) to:nil from:self]) {
      return YES;
    }
    if ([event.charactersIgnoringModifiers isEqualToString:@"x"]
        && [[NSApplication sharedApplication] sendAction:@selector(cut:) to:nil from:self]) {
      return YES;
    }
    if ([event.charactersIgnoringModifiers isEqualToString:@"z"]
        && [[NSApplication sharedApplication] sendAction:NSSelectorFromString(@"undo:") to:nil from:self]) {
      return YES;
    }
  }

  if (event.type == NSEventTypeKeyDown
      && (event.modifierFlags & NSEventModifierFlagCommand) == NSEventModifierFlagCommand
      && (event.modifierFlags & NSEventModifierFlagOption) == 0
      && (event.modifierFlags & NSEventModifierFlagShift) == NSEventModifierFlagShift
      && (event.modifierFlags & NSEventModifierFlagControl) == 0) {
    if ([event.charactersIgnoringModifiers isEqualToString:@"Z"]
        && [[NSApplication sharedApplication] sendAction:NSSelectorFromString(@"redo:") to:nil from:self]) {
      return YES;
    }
  }
  return [super performKeyEquivalent:event];
}

@end

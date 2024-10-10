#import "CommandConfigManager.h"

@implementation CommandConfigManager

- (NSArray *)loadConfig {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"command-config" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)editConfig {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"command-config" ofType:@"json"];
  NSTask *task = [[NSTask alloc] init];
  task.launchPath = @"/usr/bin/open";
  task.arguments = @[path];
  [task launch];
}

@end

#import "ActitoUserInboxPlugin.h"
#if __has_include(<actito_user_inbox/actito_user_inbox-Swift.h>)
#import <actito_user_inbox/actito_user_inbox-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_user_inbox-Swift.h"
#endif

@implementation ActitoUserInboxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoUserInboxPlugin registerWithRegistrar:registrar];
}
@end

#import "ActitoGeoPlugin.h"
#if __has_include(<actito_geo/actito_geo-Swift.h>)
#import <actito_geo/actito_geo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "actito_geo-Swift.h"
#endif

@implementation ActitoGeoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftActitoGeoPlugin registerWithRegistrar:registrar];
}
@end

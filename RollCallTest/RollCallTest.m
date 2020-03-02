//
//  RollCallTest.m
//  RollCallTest
//
//  Created by j on 3/1/20.
//Copyright © 2020 j. All rights reserved.
//

#import "RollCallTest.h"
#import "../JSRollCall/JSRollCall.h"

@interface RollCallTest()

@end


@implementation RollCallTest

/**
 * @return the single static instance of the plugin object
 */
+ (instancetype)sharedInstance
{
    static RollCallTest *plugin = nil;
    @synchronized(self) {
        if (!plugin) {
            plugin = [[self alloc] init];
        }
    }
    return plugin;
}


/**
 * A special method called by SIMBL once the application has started and all classes are initialized.
 */
+ (void)load
{
    RollCallTest *plugin = [RollCallTest sharedInstance];
    NSUInteger osx_ver = [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion;
    NSLog(@"%@ loaded into %@ on macOS 10.%ld", [self class], [[NSBundle mainBundle] bundleIdentifier], (long)osx_ver);
    
    JSRollCall *rc = [JSRollCall new];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rc allObjectsOfClassName:@"Tile" includeSubclass:YES performBlock:^(id obj) {
            NSLog(@"ROLLCALL: %@", [obj className]);
        }];
    });
}


@end

//
//  JailCheck.m
//  testJail
//
//  Created by Admin on 4/19/17.
//  Copyright © 2017 Devep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JailCheck.h"
#include <sys/utsname.h>
#import "offsets.h"

@implementation JailCheck

-(BOOL)CheckForIOS10
{
    init_offsets();
    struct utsname u = { 0 };
    uname(&u);
    
    
    if (strstr(u.version, "MarijuanARM")) {
        NSLog(@"jailbroken in IOS 10" );
        return YES;
    }

    return NO;
}
-(BOOL)CheckJail
{
    if ([self FirstCheck])
    {
        return YES;
    }
    if ([self CheckForIOS10])
    {
        return YES;
    }
    if ([self openScheme:@"cydia://"])
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)FirstCheck
{
    NSArray *myArray = @[@"Cydia", @"cydia", @"CYDIA"];
    NSString *filePath = @"/Applications";
    BOOL JailBroken = false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (int i;i < myArray.count ; i++ )
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@/%@.app" , filePath , myArray[i]]);
        if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.app" , filePath , myArray[i]]])
        {
            return YES;
        }
        
    }
    // check if twike balck list run
    if (![fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/AppStore.app" , filePath ]])
    {
        return YES;
    }
    
    return NO;

}
-(BOOL)openScheme:(NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    BOOL t1 = [application openURL:URL];
    if (t1)
    {
        
        NSLog(@"Opened %@",scheme);
        return YES;
    }
    else
    {
        NSLog(@"Cant Open %@",scheme);
        
    }
    return NO;
}


@end

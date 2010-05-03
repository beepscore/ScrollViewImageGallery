//
//  Created by Björn Sållarp on 2009-06-14.
//  NO Copyright 2009 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "ScrollViewImageGalleryAppDelegate.h"
//#import "ScrollViewImageGalleryViewController.h"

@implementation ScrollViewImageGalleryAppDelegate

@synthesize window;
// @synthesize viewController;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
//    [window addSubview:viewController.view];
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
//    [viewController release];
    [tabBarController release];
    [window release];
    [super dealloc];
}


@end

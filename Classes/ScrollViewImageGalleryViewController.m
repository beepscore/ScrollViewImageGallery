//
//  Created by Björn Sållarp on 2009-06-14.
//  NO Copyright 2009 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "ScrollViewImageGalleryViewController.h"

@implementation ScrollViewImageGalleryViewController
@synthesize openGalleryButton,galleryViewController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	if(interfaceOrientation == UIInterfaceOrientationPortrait)
		return YES;
	
	return NO;
}

// Event for the gallery button
-(IBAction) openGalleryButtonClicked:(id)sender
{
	galleryViewController = [[ImageGallery alloc] initWithNibName:@"ImageGallery" bundle:[NSBundle mainBundle]];
	[self.view addSubview:[galleryViewController view]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[openGalleryButton release];
	[galleryViewController release];
    [super dealloc];
}

@end

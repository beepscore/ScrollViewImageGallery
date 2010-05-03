//
//  Created by Björn Sållarp on 2009-06-14.
//  NO Copyright 2009 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//
#import "ImageGalleryItem.h"


@implementation ImageGalleryItem
@synthesize portraitImageView, galleryImageUrl;

- (id)initWithNibNameAndParameters:(NSString *)nibName bundle:(NSBundle *)nibBundle interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
						   imageUrl:(NSString*)imageUrl delegate:(id)delegate
{
	[super initWithNibName:nibName bundle:nibBundle];
	
	imageOrientation = interfaceOrientation;
	[self setTapListenerDelegate:delegate];
	
	galleryImageUrl = imageUrl;

	
	return self;
}

-(void)setTapListenerDelegate:(id)delegate
{
	tapListenerDelegate = delegate;
}

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIImage *img = [UIImage imageNamed:galleryImageUrl];
	[portraitImageView setImage:img];
	
	if(imageOrientation != UIInterfaceOrientationPortrait)
	{
		// If image is rotating to landscape it must always do that from
		// portrait, otherwise the images don't get scaled correctly
		UIDeviceOrientation rotateTo = imageOrientation;
		imageOrientation = UIInterfaceOrientationPortrait;
		
		// Rotate without animation
		[self rotateToDeviceOrientation:rotateTo shouldAnimate:NO];
	}
	
	// If a delegate was passed for the tap-event attach it to the image.
	if(tapListenerDelegate != nil)
	{
		[portraitImageView setDelegate:tapListenerDelegate];
	}
}

-(void) rotatePortrait
{
	portraitImageView.transform = CGAffineTransformMakeRotation(0);
	
	CGRect frame = portraitImageView.frame;
	frame.origin.y = 0;
	frame.origin.x = 0;
	frame.size.width = portraitImageView.frame.size.height;
	frame.size.height = portraitImageView.frame.size.width;
	portraitImageView.frame = frame;

}

-(void) rotateLandscapeRight
{
	
	portraitImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
		
	// imageOrientation is set to it's new value after the rotation. So right now
	// imageOrientation has the value of the orientation we are rotating from
	// The reason we are not doing anything here unless we are rotating from portrait
	// is that the width/height is flipped around. And we don't do that 
	// if the device is already in landscape.
	if(imageOrientation == UIInterfaceOrientationPortrait)
	{
		CGRect frame = portraitImageView.frame;
		frame.origin.y = 0;
		frame.origin.x = 0;
		frame.size.width = portraitImageView.frame.size.height;
		frame.size.height = portraitImageView.frame.size.width;
		portraitImageView.frame = frame;
	}
	
}

-(void) rotateLandscapeLeft
{
	portraitImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
	
	// imageOrientation is set to it's new value after the rotation. So right now
	// imageOrientation has the value of the orientation we are rotating from
	// The reason we are not doing anything here unless we are rotating from portrait
	// is that the width/height is flipped around. And we don't do that 
	// if the device is already in landscape.
	if(imageOrientation == UIInterfaceOrientationPortrait)
	{
		CGRect frame = portraitImageView.frame;
		frame.origin.y = 0;
		frame.origin.x = 0;
		frame.size.width = portraitImageView.frame.size.height;
		frame.size.height = portraitImageView.frame.size.width;
		portraitImageView.frame = frame;
	}
	
}

- (void)rotateToDeviceOrientation:(UIInterfaceOrientation)interfaceOrientation shouldAnimate:(BOOL)shouldAnimate {
	
	
	if(shouldAnimate)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		
		if(interfaceOrientation == UIInterfaceOrientationPortrait)
		{		
			[self rotatePortrait];
		}
		else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		{
			[self rotateLandscapeRight];
		}
		else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
		{
			[self rotateLandscapeLeft];
		}
		
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDoneShowCaption:finished:context:)];
		[UIView commitAnimations];
	}
	else
	{
		if(interfaceOrientation == UIInterfaceOrientationPortrait)
		{		
			[self rotatePortrait];
		}
		else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		{
			[self rotateLandscapeRight];
		}
		else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
		{
			[self rotateLandscapeLeft];
		}
	}
	
	// Store our new orientation
	imageOrientation = interfaceOrientation;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation shouldAnimate:(BOOL)shouldAnimate {
	
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[portraitImageView release];
    [super dealloc];
}


@end

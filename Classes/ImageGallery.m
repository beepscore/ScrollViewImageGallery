//
//  Created by Björn Sållarp on 2009-06-14.
//  NO Copyright 2009 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "ImageGallery.h"


@implementation ImageGallery
@synthesize scrollView, viewControllers, currentOrientation;

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// This flag will keep track of if the UI is in a rotate animation
	isRotating = NO;
	
	// Hide the statusbar to get fullscreen
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
	
	// Reposition frame because we hid the statusbar
	CGRect frame = scrollView.frame;
	frame.origin.y = -10;
	scrollView.frame = frame;
	
	//  know I added 6 images. That's why.
	imagesInGallery = 6;
	
	scrollView.pagingEnabled = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
	// store the current orientation
	currentOrientation = self.interfaceOrientation;
	
	// Create the slides for the gallery
	[self loadDataForView];
	
	// Listen to did rotate event
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(receivedRotate:) name: UIDeviceOrientationDidChangeNotification object: nil];
}

// This method is called by NSNotificationCenter when the device is rotated. See 3 lines above.
-(void) receivedRotate: (NSNotification*) notification
{
	UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
	
	if(interfaceOrientation != UIDeviceOrientationUnknown)
		[self deviceInterfaceOrientationChanged:interfaceOrientation];
}

-(void)loadDataForView
{
	// Create a collection to hold the image slides.
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < imagesInGallery; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
	
	// Update the scroll view to give it the correct size.
	[self updateScrollViewFrame];
	
	// load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

-(void)updateScrollViewFrame
{
	// Resize the scrollview depending on the interface orientation
	if(currentOrientation == UIInterfaceOrientationLandscapeLeft || currentOrientation == UIInterfaceOrientationLandscapeRight)
	{
		scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * [self.viewControllers count]);
	}
	else
	{
		// This line is a bit odd. I set the height to 200. Setting it to the height of the scrollViewFrame makes the scollview 
		// want to bounce scroll vertically. I have no idea why, but 200 does the trick!
		scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.viewControllers count], 200);
	}
	
	// Reposition all loaded frames
	for (int i = 0; i < [self.viewControllers count]; i++) {
		ImageGalleryItem* viewController = [self.viewControllers objectAtIndex:i];
        if((NSNull *)viewController != [NSNull null])
		{
			// Calculate the position of the frame depending on orientation
			viewController.view.frame = [self calculateFramePosition:viewController.view.frame page:i];
		}
    }
	
	// Move the scrollview viewport to the location of the picture the user was on before the resize
	if(currentPageInScrollview > 0)
	{
		if(currentOrientation == UIInterfaceOrientationLandscapeLeft)
		{
			scrollView.contentOffset = CGPointMake(0, currentPageInScrollview*scrollView.frame.size.height);
		}
		else if(currentOrientation == UIInterfaceOrientationLandscapeRight)
		{
			scrollView.contentOffset = CGPointMake(0, currentPageInScrollview*scrollView.frame.size.height);
		}
		else
		{
			scrollView.contentOffset = CGPointMake(currentPageInScrollview*scrollView.frame.size.width, 0);
		}
	}
	
}

- (void)imageTapped:(NSUInteger)tapCount
{
	// Show the statusbar again.
	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
	
	// Back to the startscreen, which isn't rotated :D
	[self.view removeFromSuperview];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= imagesInGallery) return;

		// replace the placeholder if necessary
		ImageGalleryItem *controller = [viewControllers objectAtIndex:page];
		if ((NSNull *)controller == [NSNull null]) {
			controller = [[ImageGalleryItem alloc] initWithNibNameAndParameters:@"ImageGalleryItem" bundle:[NSBundle mainBundle] interfaceOrientation:currentOrientation 
																				 imageUrl:[NSString stringWithFormat:@"%d.jpg", page] delegate:self];			
			[viewControllers replaceObjectAtIndex:page withObject:controller];
			[controller release];
		}
		
		// add the controller's view to the scroll view	
		if (nil == controller.view.superview) {
	
			// Position the new frame depending on the interface orientation
			controller.view.frame = [self calculateFramePosition:scrollView.frame page:page];
			
			[scrollView addSubview:controller.view];
		}
}

-(CGRect)calculateFramePosition:(CGRect)frame page:(int)page
{
	// Calculate frame position depending on the interface orientation
	if(currentOrientation == UIInterfaceOrientationLandscapeLeft)
	{
		frame.origin.x = 0;
		frame.origin.y = scrollView.contentSize.height - (frame.size.height * (page+1));
	}
	else if(currentOrientation == UIInterfaceOrientationLandscapeRight)
	{
		frame.origin.x = 0;
		frame.origin.y = frame.size.height * page;
	}
	else
	{
		frame.origin.x = frame.size.width * page;
		frame.origin.y = 0;
	}
	return frame;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	
	// If the device is in rotation this event will trigger. Ignore it until we're done
	if(isRotating == YES)
		return;

    // Switch the indicator when more than 50% of the previous/next page is visible
	if(currentOrientation == UIInterfaceOrientationLandscapeRight || currentOrientation == UIInterfaceOrientationLandscapeLeft)
	{
		CGFloat pageHeight = scrollView.frame.size.height;
		currentPageInScrollview = floor((scrollView.contentOffset.y - pageHeight / 2) / pageHeight) + 1;
	}
	else 
	{
		CGFloat pageWidth = scrollView.frame.size.width;
		currentPageInScrollview = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	}
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    int pageToLoad = [self currentImageInGallery];
	
	[self loadScrollViewWithPage:pageToLoad - 1];
    [self loadScrollViewWithPage:pageToLoad];
    [self loadScrollViewWithPage:pageToLoad + 1];
}

-(int)currentImageInGallery
{
	int currentImage = currentPageInScrollview;
	if(currentOrientation == UIInterfaceOrientationLandscapeLeft)
		currentImage = ([self.viewControllers count]-1) - currentPageInScrollview;
	
	return currentImage;
}

- (void)deviceInterfaceOrientationChanged:(UIInterfaceOrientation)interfaceOrientation {
	
	if(interfaceOrientation == currentOrientation || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
		return;
	
	if(!isRotating)
	{
		isRotating = YES;
		
		if(currentOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
		{
			currentPageInScrollview = ([self.viewControllers count]-1) - currentPageInScrollview;
		}
	    
		currentOrientation = interfaceOrientation;
		
		[self updateScrollViewFrame];
		
		// Call all allocated images and tell them it's time to rotate
		for (int i = 0; i < [self.viewControllers count]; i++) 
		{
			ImageGalleryItem *controller = [viewControllers objectAtIndex:i];
			if ((NSNull *)controller != [NSNull null]) 
			{
				BOOL shouldAnimate = NO;
				
				if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
					shouldAnimate = (i == [self.viewControllers count] -1 -currentPageInScrollview);
				else
					shouldAnimate = (i == currentPageInScrollview);
				
				[controller rotateToDeviceOrientation:interfaceOrientation shouldAnimate:shouldAnimate];
			}
		}
		
		
		
		isRotating = NO;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	if(interfaceOrientation == UIInterfaceOrientationPortrait)
		return YES;
	
	return NO;
}

// If we're running low on memory, release views that are not visible
- (void)didReceiveMemoryWarning {
	// Calculate the current page in scroll view
    int currentPage = [self currentImageInGallery];
	
	// unload the views+controllers which are no longer visible
	for (int i = 0; i < [self.viewControllers count]; i++) {
		ImageGalleryItem* viewController = [self.viewControllers objectAtIndex:i];
        if((NSNull *)viewController != [NSNull null])
		{
			if(i < currentPage-1 || i > currentPage+1)
			{
				[self.viewControllers replaceObjectAtIndex:i withObject:[NSNull null]];
			}
		}
	}
	
    [super didReceiveMemoryWarning];
}



- (void)dealloc {
	[scrollView dealloc];
	[viewControllers dealloc];
    [super dealloc];
}


@end

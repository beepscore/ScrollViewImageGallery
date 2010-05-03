//
//  Created by Björn Sållarp on 2009-06-14.
//  NO Copyright 2009 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <UIKit/UIKit.h>
#import "ImageGalleryItem.h"


@interface ImageGallery : UIViewController <UIScrollViewDelegate> {
	IBOutlet UIScrollView *scrollView;
	NSMutableArray *viewControllers;
	UIInterfaceOrientation currentOrientation;
	bool isRotating;
	int imagesInGallery;
	int currentPageInScrollview;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
- (void)imageTapped:(NSUInteger)tapCount;
- (void)updateScrollViewFrame;
- (void)loadDataForView;
-(int)currentImageInGallery;
-(CGRect)calculateFramePosition:(CGRect)frame page:(int)page;
- (void)deviceInterfaceOrientationChanged:(UIInterfaceOrientation)interfaceOrientation;
@end

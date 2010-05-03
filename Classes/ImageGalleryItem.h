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
#import "TaplistenerSubImageView.h"


@interface ImageGalleryItem : UIViewController {
	IBOutlet TaplistenerSubImageView *portraitImageView;
	UIInterfaceOrientation imageOrientation;
	id tapListenerDelegate;
	NSString *galleryImageUrl;
}
@property (nonatomic, retain) TaplistenerSubImageView *portraitImageView;
@property (nonatomic, retain) NSString *galleryImageUrl;

-(id)initWithNibNameAndParameters:(NSString *)nibName bundle:(NSBundle *)nibBundle interfaceOrientation:(UIInterfaceOrientation)interfaceOrientation imageUrl:(NSString*)imageUrl delegate:(id)delegate;
-(void)setTapListenerDelegate:(id)delegate;
-(void)rotateToDeviceOrientation:(UIInterfaceOrientation)interfaceOrientation shouldAnimate:(BOOL)shouldAnimate;

-(void) rotatePortrait;
-(void) rotateLandscapeRight;
-(void) rotateLandscapeLeft;
@end

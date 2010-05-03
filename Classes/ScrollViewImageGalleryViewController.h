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
#import "ImageGallery.h"

@interface ScrollViewImageGalleryViewController : UIViewController {
	IBOutlet UIButton *openGalleryButton;
	ImageGallery *galleryViewController;
}
@property (nonatomic, retain) IBOutlet UIButton *openGalleryButton;
@property (nonatomic, retain) IBOutlet ImageGallery *galleryViewController;

-(IBAction) openGalleryButtonClicked:(id)sender;
@end


//
//  Created by Björn Sållarp on 2009-06-14.
//  NO Copyright 2009 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "TaplistenerSubImageView.h"


@implementation TaplistenerSubImageView

// Listen to tap events and send them off to a delegate if there is one.
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSUInteger taps = [[touches anyObject] tapCount];
	
	if ([m_Delegate respondsToSelector:@selector(imageTapped:)])
	{
		[m_Delegate imageTapped:taps];
	}
}

- (void)setDelegate:(id)new_delegate
{
    m_Delegate = new_delegate;
}	

- (void)dealloc {
    [super dealloc];
}


@end
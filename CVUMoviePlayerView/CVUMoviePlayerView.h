//
//  CVUMoviePlayerView.h
//
//	Copyright (c) 2013 Claudiu-Vlad Ursache (http://www.cvursache.com/)
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import <UIKit/UIKit.h>

@interface CVUMoviePlayerView : UIView

@property(nonatomic, strong, readonly) UIView* placeholderView;
@property(nonatomic, strong, readonly) UIImageView* placeholderImageView;
@property(nonatomic, strong, readonly) UIButton* placeholderPlayVideoButton;
@property(nonatomic, strong, readwrite) UIImage* placeholderImage;

/**
 * <#add description#>
 */
- (void)pauseVideo;

/**
 * <#add description#>
 */
- (void)playVideo;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage
           videoURL:(NSURL*)videoURL
    playButtonImage:(UIImage*)playButtonImage;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage
           videoURL:(NSURL*)videoURL;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
   placeholderImage:(UIImage*)placeholderImage;

/**
 * <#add description#>
 */
- (id)initWithFrame:(CGRect)frame
           videoURL:(NSURL*)videoURL;

@end

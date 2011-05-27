//
//  FlickrPlugIn.m
//  FlickrElement
//
//  Copyright 2006-2011 Karelia Software. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  *  Redistribution of source code must retain the above copyright notice,
//     this list of conditions and the follow disclaimer.
//
//  *  Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other material provided with the distribution.
//
//  *  Neither the name of Karelia Software nor the names of its contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS-IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUR OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

#import "FlickrPlugIn.h"
#import "FlickrInspector.h"


// SVLocalizedString(@"Flickr photos", "String_On_Page_Template")
// SVLocalizedString(@" tagged with ", "String_On_Page_Template")


@implementation FlickrPlugIn


#pragma mark SVPlugIn

/*
 Flickr badge generator is at http://www.flickr.com/badge_new.gne
 */

+ (NSArray *)plugInKeys
{ 
    return [NSArray arrayWithObjects:
            @"flickrID", 
            @"tag", 
            @"number", 
            @"flashStyle", 
            @"random", 
            @"showInfo", 
            nil];
}

- (void)awakeFromNew;
{
    [super awakeFromNew];
    
    // set initial properties
    self.number = 10;
    self.showInfo = YES;
    self.tag = @"clouds";
}    

- (void)dealloc
{
    self.flickrID = nil;
    self.tag = nil;
    [super dealloc];
}


#pragma mark HTML Generation

- (void)writeHTML:(id <SVPlugInContext>)context
{
    // parse template
    [super writeHTML:context];
    
    // add dependencies
    [context addDependencyForKeyPath:@"flickrID" ofObject:self];
    [context addDependencyForKeyPath:@"tag" ofObject:self];
    [context addDependencyForKeyPath:@"number" ofObject:self];
    [context addDependencyForKeyPath:@"flashStyle" ofObject:self];
    [context addDependencyForKeyPath:@"random" ofObject:self];
    [context addDependencyForKeyPath:@"showInfo" ofObject:self];
    
    // add resources
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"FlickrPlugIn" ofType:@"css"];
    if (path && ![path isEqualToString:@""]) 
    {
        NSURL *cssURL = [NSURL fileURLWithPath:path];
        [context addResourceAtURL:cssURL destination:SVDestinationMainCSS options:0];
    }
}


#pragma mark Properties

@synthesize flickrID = _flickrID;
@synthesize tag = _tag;
@synthesize number = _number;
@synthesize flashStyle = _flashStyle;
@synthesize random = _random;
@synthesize showInfo = _showInfo;
@end

//
//  NoteModel.h
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;

@interface NoteModel : NSObject
@property (nonatomic, strong) Note *noteEntity;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSDate *dateCreated;

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
                     imageURL:(NSString *)imageURL;

- (instancetype)initWithEntity:(Note *)note;
@end

@interface NoteModel (ForBindingOnView)

- (NSString *)dateCreatedString;

@end
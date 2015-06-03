//
//  NoteModel.h
//  ExampleNotes
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface NoteModel : NSObject
@property (nonatomic, strong) Note *noteEntity;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) NSDate *dateCreated;

- (instancetype)initWithTitle:(NSString *)title
                       content:(NSString *)content
                     imageUrl:(NSString *)imageUrl;

- (instancetype)initWithEntity:(Note *)note;


@end

@interface NoteModel (ForBindingOnView)
- (NSString *)dataCreatedString;

@end
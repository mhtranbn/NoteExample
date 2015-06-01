//
//  NoteModel.m
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "NoteModel.h"
#import "Note.h"

@implementation NoteModel
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content imageURL:(NSString *)imageURL {
    self = [self init];
    if (self) {
        _title = title;
        _content = content;
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithEntity:(Note *)note {
    self = [self init];
    if (self) {
        _noteEntity = note;
        _title = note.title;
        _content = note.content;
        _imageURL = note.imageURL;
        _dateCreated = note.dateCreated;
    }
    return self;
}
@end

@implementation NoteModel (ForBindingOnView)

- (NSString *)dateCreatedString {
    return [_dateCreated description];
}

@end

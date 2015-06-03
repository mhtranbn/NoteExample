//
//  NoteModel.m
//  ExampleNotes
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "NoteModel.h"
#import "Note.h"

@implementation NoteModel
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content imageUrl:(NSString *)imageUrl{
    self = [self init];
    if (self) {
        _title = title;
        _content = content;
        _imageUrl = imageUrl;
    }
    return self;
}

- (instancetype)initWithEntity:(Note *)note {
    self = [self init];
    if (self) {
        _noteEntity = note;
        _title = note.title;
        _content = note.content;
        _imageUrl = note.imageUrl;
        _dateCreated = note.dateCreated;
        
    }
    return self;
}
@end

@implementation NoteModel (ForBindingOnView)


- (NSString *)dataCreatedString{
    return [_dateCreated description];
}

@end

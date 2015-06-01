//
//  NoteService.m
//  NoteExample
//
//  Created by mhtran on 6/1/15.
//  Copyright (c) 2015 mhtran. All rights reserved.
//

#import "NoteService.h"
#import "Note.h"
#import "NoteModel.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface NoteService ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation NoteService

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [NSOperationQueue new];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)loadAllNoteFromCoreData {
    if ([_delegate respondsToSelector:@selector(serviceBeginGetNote:)]) {
        [_delegate serviceBeginGetNote:self];
    }
    
    [_queue addOperationWithBlock:^{
        NSManagedObjectContext *backgroundContext = [NSManagedObjectContext MR_contextForCurrentThread];
        
        NSArray *allNoteEntity = [Note MR_findAllInContext:backgroundContext];
        NSMutableArray *allNoteModels = [NSMutableArray new];
        for (Note *noteEntity in allNoteEntity) {
            NoteModel *model = [[NoteModel alloc] initWithEntity:noteEntity];
            [allNoteModels addObject:model];
        }
        
        if ([_delegate respondsToSelector:@selector(serviceDidCompleteGetNote:withModels:)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_delegate serviceDidCompleteGetNote:self withModels:allNoteModels.copy];
            }];
        }
    }];
}

- (void)addNoteWithModel:(NoteModel *)noteModel {
    if ([_delegate respondsToSelector:@selector(serviceBeginSaveNote:)]) {
        [_delegate serviceBeginSaveNote:self];
    }
    
    [_queue addOperationWithBlock:^{
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            Note *newEntity = [Note MR_createInContext:localContext];
            newEntity.title = noteModel.title;
            newEntity.content = noteModel.content;
            newEntity.imageURL = noteModel.imageURL;
            newEntity.dateCreated = [NSDate date];
        }];
        
        if ([_delegate respondsToSelector:@selector(serviceDidCompleteSaveNote:)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_delegate serviceDidCompleteSaveNote:self];
            }];
        }
    }];
    
}


@end

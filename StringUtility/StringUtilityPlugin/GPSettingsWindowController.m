//
//  GPSettingsWindowController.m
//  StringUtility
//
//  Created by Konstantin Kabanov on 07/03/2017.
//  Copyright © 2017 GoPro Inc. All rights reserved.
//

#import "GPSettingsWindowController.h"

#import "GPPluginConfiguration.h"

@interface GPSettingsWindowController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (strong) NSMutableArray *selectedLocaleIdentifiers;
@property (strong) NSArray *languages;

@end

@implementation GPSettingsWindowController

- (NSString *)windowNibName {
    return [self className];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.selectedLocaleIdentifiers = [[GPPluginConfiguration sharedConfiguration].localeIdentifiers mutableCopy];
    
    if (!self.selectedLocaleIdentifiers) {
        self.selectedLocaleIdentifiers = [@[] mutableCopy];
    }
    
    NSMutableArray *temp = [@[] mutableCopy];
    
    for (NSString *localeIdentifier in [NSLocale availableLocaleIdentifiers]) {
        NSString *displayName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:localeIdentifier];
        
        NSDictionary *language = @{@"localeIdentifier": localeIdentifier, @"displayName": displayName};

        [temp addObject:language];
    }
    
    [temp sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES]]];
    
    self.languages = temp;
    
    [self.tableView reloadData];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self close];
}

- (IBAction)saveButtonAction:(id)sender {
    [GPPluginConfiguration sharedConfiguration].localeIdentifiers = self.selectedLocaleIdentifiers;
    [[GPPluginConfiguration sharedConfiguration] save];
    
    [self close];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.languages count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSButtonCell *buttonCell = [tableColumn dataCell];
    
    return buttonCell;
}

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSButtonCell *buttonCell = [tableColumn dataCell];
    
    [buttonCell setState:[self.selectedLocaleIdentifiers containsObject:self.languages[row][@"localeIdentifier"]]];
    [buttonCell setTitle:self.languages[row][@"displayName"]];
    
    return buttonCell;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSNumber *newValue = object;
    
    NSDictionary *language = self.languages[row];
    
    if ([newValue boolValue]) {
        [self.selectedLocaleIdentifiers addObject:language[@"localeIdentifier"]];
    } else {
        [self.selectedLocaleIdentifiers removeObject:language[@"localeIdentifier"]];
    }
}

@end


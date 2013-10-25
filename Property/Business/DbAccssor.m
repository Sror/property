
#import "DbAccssor.h"



@implementation DbAccssor
sqlite3* database;

-(id) init
{
    
    if ((self = [super init]))
    {
        
        [self initializeDatabase];
    }
    return self;
}

bool DatabaseFound;



-(int) GetContentVersion
{
    
    if(DatabaseFound==false)
    {
        return 0;}
    
    
    NSString *sql =@"SELECT ContentVersion.version FROM ContentVersion";
      sqlite3_stmt *statement;
    
     int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1,  & statement, NULL);
    int   contentVersion=0;
    if ( sqlResult== SQLITE_OK) {
         while (sqlite3_step(statement) == SQLITE_ROW) {
             contentVersion= [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,0)]intValue];
            }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        //  NSLog(@"%d",sqlResult);
    }
    return contentVersion;
    
}


-(Magazine *) GetMagazine:(int)categoryId :(NSString*)usedLangApprev{
    if (DatabaseFound==FALSE) {
        return NULL;
    }

    Magazine *  magazine = [[Magazine alloc]init];
    
    NSString * selectImagesSql =[@"SELECT MagazineImagePK, Reference,MagazineImageOrder, TitleLangApprev,  DescriptionLangApprev, CategoryList FROM MagazineImage %@ ORDER BY MagazineImageOrder" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
 NSString* whereStr=@"";
    
    if (categoryId>0) {
    whereStr =[NSString stringWithFormat:@"WHERE CategoryList LIKE '%%,%d,%%'",categoryId ];
        
    }
    selectImagesSql =[NSString stringWithFormat:selectImagesSql,whereStr];
    
    
    
    NSMutableArray *imageList = [[NSMutableArray alloc] init] ;
    
    
     sqlite3_stmt *statement;
    
     int sqlResult = sqlite3_prepare_v2(database, [selectImagesSql UTF8String], -1,  & statement, NULL);
    
    if ( sqlResult== SQLITE_OK) {
         while (sqlite3_step(statement) == SQLITE_ROW) {
            
        ImageItem *imageItem=[[ImageItem alloc]init];
            
        imageItem.ImageItemId=sqlite3_column_int(statement, 0);
        imageItem.ImageItemOrder=sqlite3_column_int(statement, 2);
            
        imageItem.ImageItemTitle =[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,3)];
            
            
        imageItem.ImageItemDescription=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,4)];
            
            
        imageItem.ImageItemPath =[NSString stringWithFormat:@"%@/media/images/magazine/%@.jpg",MagazineContentPath,[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)]];
            
           
            
        NSString * selectImageTagsSql =[@"SELECT ImageTagPK, TitleLangApprev, DescriptionLangApprev, XCoordinate, YCoordinate FROM ImageTag WHERE MagazineImageFK = %d" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
            
        selectImageTagsSql =[NSString stringWithFormat:selectImageTagsSql,imageItem.ImageItemId];
             
             
             
        NSMutableArray *imageTagList = [[NSMutableArray alloc] init] ;
        sqlite3_stmt *statement2;
             
             int sqlResult2 = sqlite3_prepare_v2(database, [selectImageTagsSql UTF8String], -1,  & statement2, NULL);
             
             if ( sqlResult2== SQLITE_OK) {
                 while (sqlite3_step(statement2) == SQLITE_ROW)
                 {
                     MagazineImageTag * imagetag = [[MagazineImageTag alloc]init];
                     imagetag.ImageTagId=sqlite3_column_int(statement2, 0);
                     imagetag.ImageTagTitle=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,1)];
                     imagetag.ImageTagDescription=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,2)];
                     imagetag.XCoordinate=sqlite3_column_int(statement2, 3);
                     imagetag.YCoordinate=sqlite3_column_int(statement2, 4);
                     [imageTagList addObject:imagetag];
                 }
             }
             
             imageItem.TagList=imageTagList;
            
            // Add the product to the products array
            [imageList addObject:imageItem];
            
            
            
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    
    magazine.MagazineImageList=imageList;
    
    
    
    return magazine;
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}














NSString *    MagazineContentPath;



// Open the database connection
-(void)initializeDatabase {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    MagazineContentPath = [documentsDir stringByAppendingPathComponent:@"PAMagazine"];
    
    
    
    NSString *databasePath =[MagazineContentPath stringByAppendingPathComponent:@"advisor.db"];
    
    
    
    
    
    
    
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
     success = [fileManager fileExistsAtPath:databasePath];
    if (!success)
    {
        DatabaseFound=FALSE;
        return;
        
    }
    
    
    
    
    
    
    
    if (sqlite3_open([databasePath UTF8String],  & database) == SQLITE_OK)
    {
        DatabaseFound=true;
    
    }
    else
    {
        DatabaseFound=FALSE;
        
    }
}

-(void) closeDatabase
{
    // Close the database.
    if (sqlite3_close(database) != SQLITE_OK) {
        NSLog(@"Error: failed to close database");
        return;
    }
    // NSLog(@"Close DataBase");
}


/*
-(NSMutableArray*) GetNeedUpdateProductList{
    
    NSMutableArray *productList = [[NSMutableArray alloc] init] ;
    
    //  The SQL statement that we plan on executing against the database
    NSString *sql = @"SELECT ProductUpdate.ProductUpdatePK, ProductUpdate.ProductId, ProductUpdate.ProductVersion, ProductUpdate.ProductName FROM ProductUpdate where ProductUpdate.NeedsUpdate=1";
    
    
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1,  & statement, NULL);
    
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        // NSLog([NSString stringWithFormat:@"%d"],sqlite3_step(statement));
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            ProductItem *productItem=[[ProductItem alloc]init];
            
            productItem.ProductId=sqlite3_column_int(statement, 0);
            
            char *productIdStr = (char *)sqlite3_column_text(statement,1);
            productItem.ProductIdStr =[NSString stringWithUTF8String:productIdStr];
            
            productItem.ProductVersion=sqlite3_column_int(statement, 2);
            
            char *productName = (char *)sqlite3_column_text(statement,3);
            productItem.ProductName =[NSString stringWithUTF8String:productName];
            
            
            
            
            
            
            // Add the product to the products array
            [productList addObject:productItem];
            
            // Release the local product object because the object is retained
            // when we add it to the array
            [productItem.ProductIdStr release];
            [productItem.ProductName release];
            
            [productItem release];
            
            
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    return productList;}




-(NSMutableArray*) GetProductList
{
    NSMutableArray *productList = [[NSMutableArray alloc] init] ;
    
    //  The SQL statement that we plan on executing against the database
    NSString *sql =@"SELECT ProductUpdate.ProductUpdatePK, ProductUpdate.ProductId, ProductUpdate.ProductVersion, ProductUpdate.ProductName FROM ProductUpdate";
    
    
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1,  & statement, NULL);
    
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        // NSLog([NSString stringWithFormat:@"%d"],sqlite3_step(statement));
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            ProductItem *productItem=[[ProductItem alloc]init];
            
            productItem.ProductId=sqlite3_column_int(statement, 0);
            
            char *productIdStr = (char *)sqlite3_column_text(statement,1);
            productItem.ProductIdStr =[NSString stringWithUTF8String:productIdStr];
            
            productItem.ProductVersion=sqlite3_column_int(statement, 2);
            
            char *productName = (char *)sqlite3_column_text(statement,3);
            productItem.ProductName =[NSString stringWithUTF8String:productName];
            
            
            
            
            
            
            // Add the product to the products array
            [productList addObject:productItem];
            
            // Release the local product object because the object is retained
            // when we add it to the array
            [productItem.ProductIdStr release];
            [productItem.ProductName release];
            
            [productItem release];
            
            
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        //  NSLog(@"%d",sqlResult);
    }
    return productList;
    
}






- (NSMutableArray*) GetUnSyncedDeviceEventList
{
    
    //  The array of products that we will create
    NSMutableArray *deviceEventList = [[[NSMutableArray alloc] init]autorelease];
    
    //  The SQL statement that we plan on executing against the database
    NSString *sql = @"SELECT EventPK, EventCategoryFK, EventTypeFK, EventTimeStamp, EventData, IsEventSynced FROM DeviceEvent limit 30";
    
    
    
    //  The SQLite statement object that will hold our result set
    sqlite3_stmt *statement;
    
    // Prepare the statement to compile the SQL query into byte-code
    int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1,  & statement, NULL);
    
    if ( sqlResult== SQLITE_OK) {
        // Step through the results - once for each row.
        // NSLog([NSString stringWithFormat:@"%d"],sqlite3_step(statement));
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            DeviceEventModel *deviceEventModel=[[DeviceEventModel alloc]init];
            
            deviceEventModel.EventId=sqlite3_column_int(statement, 0);
            deviceEventModel.EventCategoryId=sqlite3_column_int(statement, 1);
            deviceEventModel.EventTypeId=sqlite3_column_int(statement, 2);
            
            
            
            char *EventTimeStamp = (char *)sqlite3_column_text(statement,3);
            char *EventData = (char *)sqlite3_column_text(statement, 4);
            deviceEventModel.IsEventSynced=sqlite3_column_int(statement, 5);
            
            
            deviceEventModel.EventTimeStamp=[NSString stringWithUTF8String:EventTimeStamp];
            deviceEventModel.EventData=[NSString stringWithUTF8String:EventData];
            
            
            
            // Add the product to the products array
            [deviceEventList addObject:deviceEventModel];
            
            // Release the local product object because the object is retained
            // when we add it to the array
            [deviceEventModel release];
            
            
            
        }
        
        // finalize the statement to release its resources
        sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Problem with the database:");
        //NSLog(@"%d",sqlResult);
    }
    return deviceEventList;
    
    
    
}


*/







@end

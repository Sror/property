
#import "DbAccessor.h"

@implementation DbAccessor


-(id) init
{
    if ((self = [super init]))
    {
        [self initializeDatabase];
        [self GetUserSelectedLang];
    }
    return self;
}

-(void)initializeDatabase
{
    NSArray *paths         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    MagazineContentPath    = [documentsDir stringByAppendingPathComponent:@"PAMagazine"];
    NSString *databasePath = [MagazineContentPath stringByAppendingPathComponent:@"advisor.db"];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success                    = [fileManager fileExistsAtPath:databasePath];
    if (!success)
    {
        DatabaseFound=FALSE;
        return;
    }

    if (sqlite3_open([databasePath UTF8String],  & database) == SQLITE_OK)
        DatabaseFound=true;
    else
        DatabaseFound=FALSE;
}

-(void) closeDatabase
{
    if (sqlite3_close(database) != SQLITE_OK)
        return;
}

-(int) GetContentVersion
{
    if(DatabaseFound == false)
        return 0;
    
    NSString *sql = @"SELECT ContentVersion.version FROM ContentVersion";
    sqlite3_stmt *statement;
    
    int sqlResult      = sqlite3_prepare_v2(database, [sql UTF8String], -1,  & statement, NULL);
    int contentVersion = 0;
    if ( sqlResult == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            contentVersion = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,0)]intValue];
        }
        sqlite3_finalize(statement);
    }
    return contentVersion;
}

-(NSMutableArray*)LoadLocationList
{
    if (DatabaseFound==FALSE)
        return NULL;
    
    NSString * selectSql =[@"SELECT LocationPK, LocationNameLangApprev FROM Location ORDER BY LocationNameLangApprev" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
    
    NSMutableArray *fillingOptionsList = [[NSMutableArray alloc] init] ;
    
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [selectSql UTF8String], -1,  &statement, NULL);
    
    if ( sqlResult== SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            FillingOptionItem *item    = [[FillingOptionItem alloc] init];
            item.FillingOptionItemId   = sqlite3_column_int(statement, 0);
            item.FillingOptionItemName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)];
            [fillingOptionsList addObject:item];
        }
    }
    sqlite3_finalize(statement);
    return fillingOptionsList;
}


-(NSMutableArray*)LoadPropertyTypeList
{
    if (DatabaseFound==FALSE)
        return NULL;
     
    NSString * selectSql =[@"SELECT PropertyTypePK, PropertyTypeNameLangApprev FROM PropertyType ORDER BY PropertyTypeNameLangApprev" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
    
    NSMutableArray *fillingOptionsList = [[NSMutableArray alloc] init] ;
    
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [selectSql UTF8String], -1,  &statement, NULL);
    
    if (sqlResult == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            FillingOptionItem *item    = [[FillingOptionItem alloc]init];
            item.FillingOptionItemId   = sqlite3_column_int(statement, 0);
            item.FillingOptionItemName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)];
            [fillingOptionsList addObject:item];
        }
    }
    sqlite3_finalize(statement);
    return fillingOptionsList;
}


-(NSMutableArray*)LoadSalesTypeList
{
    if (DatabaseFound==FALSE)
        return NULL;

    NSString * selectSql =[@"SELECT SaleTypePK, SaleTypeNameLangApprev FROM SaleType ORDER BY SaleTypeNameLangApprev" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
    
    NSMutableArray *fillingOptionsList = [[NSMutableArray alloc] init] ;
    
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [selectSql UTF8String], -1,  & statement, NULL);
    
    if (sqlResult == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            FillingOptionItem *item    = [[FillingOptionItem alloc]init];
            item.FillingOptionItemId   = sqlite3_column_int(statement, 0);
            item.FillingOptionItemName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)];
            [fillingOptionsList addObject:item];
        }
    }
    sqlite3_finalize(statement);
    return fillingOptionsList;
}


-(NSMutableArray*)LoadPropertyList:(int)locationId :(int)propertyTypeId :(int)SalesTypeId :(int)categryId{

    if (DatabaseFound==FALSE)
        return NULL;
    
    NSMutableArray * queryList = [[NSMutableArray alloc]init];
    
    if (locationId > 0)
        [queryList addObject:[NSString stringWithFormat:@"LocationPK=%d",locationId]];
    
    if (propertyTypeId > 0)
        [queryList addObject:[NSString stringWithFormat:@"PropertyTypePK=%d",propertyTypeId]];
    
    if (SalesTypeId > 0)
        [queryList addObject:[NSString stringWithFormat:@"SaleTypePK=%d",SalesTypeId]];

      if (categryId == 0)
          categryId = (int)egyptResidential;
    
    if (categryId > 0)
        [queryList addObject:[NSString stringWithFormat:@"CategoryPK=%d",categryId]];
    
    NSString * whereStr  = [NSString stringWithFormat:@" where %@", [queryList componentsJoinedByString:@" and "]];
 
    NSString * selectSql = [NSString stringWithFormat:[@"SELECT  PropertyPK,   BedroomFrom,  BedroomTo,  BathroomFrom,  BathroomTo, AreaFrom, AreaTo, PriceFrom, PriceTo, TitleLangApprev, DescriptionLangApprev, NumberOfImages, PropertyTypeNameLangApprev, SaleTypeNameLangApprev, LocationNameLangApprev,  Reference, Currency  FROM  VwProperty %@" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev],whereStr];
    
    
    NSMutableArray *propertyList = [[NSMutableArray alloc] init] ;
    
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [selectSql UTF8String], -1,  & statement, NULL);
    
    if (sqlResult== SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            PropertyItem * propertyItem      = [[PropertyItem alloc]init];
            propertyItem.PropertyItemId      = sqlite3_column_int64(statement, 0);
            propertyItem.BedRoomsFrom        = sqlite3_column_int(statement, 1);
            propertyItem.BedRoomsTo          = sqlite3_column_int(statement,2 );
            propertyItem.BathRoomsFrom       = sqlite3_column_int(statement, 3);
            propertyItem.BathRoomsTo         = sqlite3_column_int(statement, 4);
            propertyItem.AreaFrom            = sqlite3_column_double(statement, 5);
            propertyItem.AreaTo              = sqlite3_column_double(statement, 6);
            propertyItem.PriceFrom           = sqlite3_column_double(statement,7 );
            propertyItem.PriceTo             = sqlite3_column_double(statement, 8);
            propertyItem.PropertyTitle       = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,9)];
            propertyItem.PropertyDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,10)];
            
            int imageCount                   = sqlite3_column_int(statement, 11);
            propertyItem.NumberOfImages      = imageCount;
            
            propertyItem.PropertyType        = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,12)];
            propertyItem.SaleType            = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,13)];
            propertyItem.Location            = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,14)];
            propertyItem.PropertyReference   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,15)];
            propertyItem.Currency            = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,16)];
            
            NSString* imagePathTemplate      = @"%@/media/images/properties/%@-%d.jpg";
            propertyItem.ImageList           = [[NSMutableArray alloc]init];
            if(imageCount==0)
            {
                propertyItem.ThumbNail = [NSString stringWithFormat:imagePathTemplate,MagazineContentPath,@"defthumb",0];
                [propertyItem.ImageList addObject:[NSString stringWithFormat:imagePathTemplate,MagazineContentPath,@"defimage",1]];
            }
            else
            {
                propertyItem.ThumbNail = [NSString stringWithFormat:imagePathTemplate,MagazineContentPath,propertyItem.PropertyReference,0];
                
                for (int index = 1; index <= imageCount ; index++)
                {
                    [propertyItem.ImageList addObject:[NSString stringWithFormat:imagePathTemplate,MagazineContentPath,propertyItem.PropertyReference,index]];
                }
            }
            [propertyList addObject:propertyItem];
        }
    }
    else
    {
        NSLog(@"%s",sqlite3_errmsg(database));
    }
    sqlite3_finalize(statement);
    return propertyList;
}


-(PropertyItem*)LoadProperty:(long)propertyId
{
    if (DatabaseFound == FALSE)
        return NULL;
    
    NSString * whereStr  = [NSString stringWithFormat:@" where PropertyPK= %ld", propertyId];
    
    int   PropertyTypePK, LocationPK;
    
    NSString * selectSql = [NSString stringWithFormat:[@"SELECT  PropertyPK,   BedroomFrom,  BedroomTo,  BathroomFrom,  BathroomTo, AreaFrom, AreaTo, PriceFrom, PriceTo, TitleLangApprev, DescriptionLangApprev, NumberOfImages, PropertyTypeNameLangApprev, SaleTypeNameLangApprev, LocationNameLangApprev,  Reference, Currency, PropertyTypePK, LocationPK FROM  VwProperty %@" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev],whereStr];
 
    sqlite3_stmt *statement;
    int sqlResult = sqlite3_prepare_v2(database, [selectSql UTF8String], -1,  & statement, NULL);
    PropertyItem * cpropertyItem = [[PropertyItem alloc]init];
    
    if (sqlResult == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            cpropertyItem.PropertyItemId      = sqlite3_column_int64(statement, 0);
            cpropertyItem.BedRoomsFrom        = sqlite3_column_int(statement, 1);
            cpropertyItem.BedRoomsTo          = sqlite3_column_int(statement,2 );
            cpropertyItem.BathRoomsFrom       = sqlite3_column_int(statement, 3);
            cpropertyItem.BathRoomsTo         = sqlite3_column_int(statement, 4);
            cpropertyItem.AreaFrom            = sqlite3_column_double(statement, 5);
            cpropertyItem.AreaTo              = sqlite3_column_double(statement, 6);
            cpropertyItem.PriceFrom           = sqlite3_column_double(statement,7 );
            cpropertyItem.PriceTo             = sqlite3_column_double(statement, 8);
            cpropertyItem.PropertyTitle       = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,9)];
            cpropertyItem.PropertyDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,10)];
            
            int imageCount               = sqlite3_column_int(statement, 11);
            cpropertyItem.NumberOfImages = imageCount;
            
            cpropertyItem.PropertyType      = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,12)];
            cpropertyItem.SaleType          = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,13)];
            cpropertyItem.Location          = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,14)];
            cpropertyItem.PropertyReference = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,15)];
            cpropertyItem.Currency          = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,16)];
            
            PropertyTypePK = sqlite3_column_int(statement, 17);
            LocationPK     = sqlite3_column_int(statement, 18);
            
            NSString *imagePathTemplate = @"%@/media/images/properties/%@-%d.jpg";
     
            cpropertyItem.ImageList = [[NSMutableArray alloc]init];
            
            if(imageCount == 0)
            {
                cpropertyItem.ThumbNail = [NSString stringWithFormat:imagePathTemplate,MagazineContentPath,@"defthumb",0];
                [cpropertyItem.ImageList addObject:[NSString stringWithFormat:imagePathTemplate,MagazineContentPath,@"defimage",1]];
            }
            else
            {
                cpropertyItem.ThumbNail = [NSString stringWithFormat:imagePathTemplate,MagazineContentPath,cpropertyItem.PropertyReference,0];
                
                for (int index = 1; index <= imageCount; index++)
                {
                    [cpropertyItem.ImageList addObject:[NSString stringWithFormat:imagePathTemplate,MagazineContentPath,cpropertyItem.PropertyReference,index]];
                }
            }
        }
        whereStr  = [NSString stringWithFormat:@" where  PropertyPK<> %ld and PropertyTypePK=%d", propertyId,PropertyTypePK];
        
        selectSql = [NSString stringWithFormat:[@"SELECT  PropertyPK,   BedroomFrom,  BedroomTo,  BathroomFrom,  BathroomTo, AreaFrom, AreaTo, PriceFrom, PriceTo, TitleLangApprev, DescriptionLangApprev, NumberOfImages, PropertyTypeNameLangApprev, SaleTypeNameLangApprev, LocationNameLangApprev,  Reference, Currency  FROM  VwProperty %@ limit 5" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev],whereStr];
  
        sqlite3_stmt *statement2;
        cpropertyItem.SuggestedPropertyList = [[NSMutableArray alloc] init] ;
            
        int sqlResult = sqlite3_prepare_v2(database, [selectSql UTF8String], -1,  & statement2, NULL);
              
        if ( sqlResult== SQLITE_OK)
        {
            while (sqlite3_step(statement2) == SQLITE_ROW)
            {
                SuggestedPropertyItem * suggestedPropertyItem = [[SuggestedPropertyItem alloc]init];
                suggestedPropertyItem.PropertyItemId          = sqlite3_column_int64(statement2, 0);
                suggestedPropertyItem.PropertyTitle           = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,9)];
                
                int imageCount                     = sqlite3_column_int(statement2, 11);
                suggestedPropertyItem.PropertyType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,12)];
                suggestedPropertyItem.SaleType  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,13)];
                suggestedPropertyItem.Location  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,14)];
                NSString* imagePathTemplate     = @"%@/media/images/properties/%@-%d.jpg";
                NSString * propertyReference    = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,15)];
                if(imageCount == 0)
                {
                    suggestedPropertyItem.ThumbNail = [NSString stringWithFormat:imagePathTemplate,MagazineContentPath,@"defthumb",0];
                }
                else
                {
                    suggestedPropertyItem.ThumbNail = [NSString stringWithFormat:imagePathTemplate,MagazineContentPath,propertyReference,0];
                }
                [cpropertyItem.SuggestedPropertyList addObject:suggestedPropertyItem];
            }
        }
    }
    else
    {
        NSLog(@"%s",sqlite3_errmsg(database));
    }
    sqlite3_finalize(statement);
    return cpropertyItem;
}

-(void)GetUserSelectedLang
{
    usedLangApprev=@"Eng";
}


-(Magazine *) GetMagazine:(int)categoryId
{
    if (DatabaseFound==FALSE)
    {
        return NULL;
    }

    Magazine *magazine        = [[Magazine alloc]init];
    NSString *selectImagesSql = [@"SELECT MagazineImagePK, Reference,MagazineImageOrder, TitleLangApprev,  DescriptionLangApprev, CategoryList FROM MagazineImage %@ ORDER BY MagazineImageOrder" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
    
    NSString* whereStr = @"";
    
    if (categoryId > 0)
        whereStr = [NSString stringWithFormat:@"WHERE CategoryList LIKE '%%,%d,%%'",categoryId ];
 
    selectImagesSql = [NSString stringWithFormat:selectImagesSql,whereStr];
    
    NSMutableArray *imageList = [[NSMutableArray alloc] init] ;
    
    sqlite3_stmt *statement;
    
    int sqlResult = sqlite3_prepare_v2(database, [selectImagesSql UTF8String], -1,  & statement, NULL);
    
    if ( sqlResult == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            MagazineImageItem *imageItem = [[MagazineImageItem alloc]init];
            
            imageItem.ImageItemId          = sqlite3_column_int64(statement, 0);
            imageItem.ImageItemOrder       = sqlite3_column_int(statement, 2);
            imageItem.ImageItemTitle       = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,3)];
            imageItem.ImageItemDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,4)];
            imageItem.ImageItemPath        = [NSString stringWithFormat:@"%@/media/images/magazine/%@.jpg",MagazineContentPath,[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)]];
      
             NSString * selectImageTagsSql = [@"SELECT ImageTagPK, TitleLangApprev, DescriptionLangApprev, XCoordinate, YCoordinate FROM ImageTag WHERE MagazineImageFK = %ld" stringByReplacingOccurrencesOfString:@"LangApprev" withString:usedLangApprev];
            
             selectImageTagsSql = [NSString stringWithFormat:selectImageTagsSql,imageItem.ImageItemId];
             
             NSMutableArray *imageTagList = [[NSMutableArray alloc] init] ;
             sqlite3_stmt *statement2;
             
             int sqlResult2 = sqlite3_prepare_v2(database, [selectImageTagsSql UTF8String], -1,  & statement2, NULL);
             
             if ( sqlResult2 == SQLITE_OK)
             {
                 while (sqlite3_step(statement2) == SQLITE_ROW)
                 {
                     MagazineImageTag * imagetag  = [[MagazineImageTag alloc]init];
                     imagetag.ImageTagId          = sqlite3_column_int64(statement2, 0);
                     imagetag.ImageTagTitle       = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,1)];
                     imagetag.ImageTagDescription = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement2,2)];
                     imagetag.XCoordinate         = (sqlite3_column_int(statement2, 3)*0.64);
                imagetag.YCoordinate              = (sqlite3_column_int(statement2, 4)*0.64);
                      [imageTagList addObject:imagetag];
                 }
             }
             
             imageItem.TagList = imageTagList;
            [imageList addObject:imageItem];
        }
        sqlite3_finalize(statement);
    }
    magazine.MagazineImageList=imageList;
    return magazine;
}

@end

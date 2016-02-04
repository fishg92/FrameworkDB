CREATE TABLE [dbo].[JoinExternalTaskMetaDataApplicationUserAudit] (
    [pk]                                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                            DATETIME     NULL,
    [AuditEndDate]                              DATETIME     NULL,
    [AuditUser]                                 VARCHAR (50) NULL,
    [AuditMachine]                              VARCHAR (15) NULL,
    [AuditDeleted]                              TINYINT      NULL,
    [pkJoinExternalTaskMetaDataApplicationUser] DECIMAL (18) NOT NULL,
    [fkExternalTaskMetaData]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                         DECIMAL (18) NOT NULL,
    [UserRead]                                  BIT          NOT NULL,
    [UserReadNote]                              BIT          CONSTRAINT [DF_JoinExternalTaskMetaDataApplicationUserAudit_UserReadNote] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinExternalTaskMetaDataApplicationUserAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinExternalTaskMetaDataApplicationUserAudit]
    ON [dbo].[JoinExternalTaskMetaDataApplicationUserAudit]([pkJoinExternalTaskMetaDataApplicationUser] ASC);


﻿CREATE TABLE [dbo].[FormJoinFormFolderFormNameAudit] (
    [pk]                           DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME     NULL,
    [AuditEndDate]                 DATETIME     NULL,
    [AuditUser]                    VARCHAR (50) NULL,
    [AuditMachine]                 VARCHAR (15) NULL,
    [AuditDeleted]                 TINYINT      NULL,
    [pkFormJoinFormFolderFormName] DECIMAL (18) NOT NULL,
    [fkFormFolder]                 DECIMAL (18) NOT NULL,
    [fkFormName]                   DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_FormJoinFormFolderFormNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinFormFolderFormNameAudit]
    ON [dbo].[FormJoinFormFolderFormNameAudit]([pkFormJoinFormFolderFormName] ASC);


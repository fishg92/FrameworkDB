CREATE TABLE [dbo].[FormQuickListAutoFillValueAudit] (
    [pk]                                 DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                     DATETIME       NULL,
    [AuditEndDate]                       DATETIME       NULL,
    [AuditUser]                          VARCHAR (50)   NULL,
    [AuditMachine]                       VARCHAR (15)   NULL,
    [AuditDeleted]                       TINYINT        NULL,
    [pkFormQuickListAutoFillValue]       DECIMAL (18)   NOT NULL,
    [fkFormQuickListFormName]            DECIMAL (18)   NOT NULL,
    [KeyWordName]                        VARCHAR (50)   NULL,
    [RowNumber]                          INT            NOT NULL,
    [fkFormQuickListAutoFillValueSmall]  DECIMAL (18)   NULL,
    [fkFormQuickListAutoFillValueMedium] DECIMAL (18)   NULL,
    [fkFormQuickListAutoFillValueLarge]  DECIMAL (18)   NULL,
    [fkFormQuickListAutoFillValueHuge]   DECIMAL (18)   NULL,
    [FormQuickListAutoFillValue]         VARCHAR (5000) NULL,
    [AutoFillGroupName]                  VARCHAR (50)   NULL,
    CONSTRAINT [PK_FormQuickListAutoFillValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormQuickListAutoFillValueAudit]
    ON [dbo].[FormQuickListAutoFillValueAudit]([pkFormQuickListAutoFillValue] ASC);


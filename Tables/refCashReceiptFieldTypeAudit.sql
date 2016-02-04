CREATE TABLE [dbo].[refCashReceiptFieldTypeAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkrefCashReceiptFieldType] DECIMAL (18) NOT NULL,
    [FieldTypeName]             VARCHAR (50) NULL,
    [FieldTypeValue]            INT          NOT NULL,
    CONSTRAINT [PK_refCashReceiptFieldTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefCashReceiptFieldTypeAudit]
    ON [dbo].[refCashReceiptFieldTypeAudit]([pkrefCashReceiptFieldType] ASC);


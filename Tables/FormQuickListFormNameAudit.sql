CREATE TABLE [dbo].[FormQuickListFormNameAudit] (
    [pk]                      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME      NULL,
    [AuditEndDate]            DATETIME      NULL,
    [AuditUser]               VARCHAR (50)  NULL,
    [AuditMachine]            VARCHAR (15)  NULL,
    [AuditDeleted]            TINYINT       NULL,
    [pkFormQuickListFormName] DECIMAL (18)  NOT NULL,
    [fkFormName]              DECIMAL (18)  NOT NULL,
    [fkFormUser]              DECIMAL (18)  NOT NULL,
    [QuickListFormName]       VARCHAR (255) NULL,
    [DateAdded]               SMALLDATETIME NOT NULL,
    [Inactive]                TINYINT       NOT NULL,
    [FormOrder]               INT           NOT NULL,
    [fkCPClientCase]          DECIMAL (18)  NULL,
    [fkCPClient]              DECIMAL (18)  NULL,
    CONSTRAINT [PK_FormQuickListFormNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormQuickListFormNameAudit]
    ON [dbo].[FormQuickListFormNameAudit]([pkFormQuickListFormName] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'foriegn key to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormNameAudit', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'foriegn key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormNameAudit', @level2type = N'COLUMN', @level2name = N'fkCPClient';


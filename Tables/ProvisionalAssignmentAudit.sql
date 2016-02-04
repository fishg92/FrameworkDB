CREATE TABLE [dbo].[ProvisionalAssignmentAudit] (
    [pk]                      DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME     NULL,
    [AuditEndDate]            DATETIME     NULL,
    [AuditUser]               VARCHAR (50) NULL,
    [AuditEffectiveUser]      VARCHAR (50) NULL,
    [AuditEffectiveDate]      DATETIME     NULL,
    [AuditMachine]            VARCHAR (15) NULL,
    [AuditDeleted]            TINYINT      NULL,
    [pkProvisionalAssignment] DECIMAL (18) NOT NULL,
    [fkRecipientPool]         DECIMAL (18) NOT NULL,
    [fkSuggestedUser]         DECIMAL (18) NOT NULL,
    [fkAssigningUser]         DECIMAL (18) NOT NULL,
    [SuggestionAccepted]      BIT          NOT NULL,
    CONSTRAINT [PK_ProvisionalAssignmentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkProvisionalAssignmentAudit]
    ON [dbo].[ProvisionalAssignmentAudit]([pkProvisionalAssignment] ASC);


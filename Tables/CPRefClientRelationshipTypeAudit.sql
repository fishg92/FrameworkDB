CREATE TABLE [dbo].[CPRefClientRelationshipTypeAudit] (
    [pk]                            DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME      NULL,
    [AuditEndDate]                  DATETIME      NULL,
    [AuditUser]                     VARCHAR (50)  NULL,
    [AuditMachine]                  VARCHAR (15)  NULL,
    [AuditDeleted]                  TINYINT       NULL,
    [pkCPRefClientRelationshipType] DECIMAL (18)  NOT NULL,
    [Description]                   VARCHAR (255) NULL,
    [LetterAssignment]              VARCHAR (5)   NULL,
    [LetterAssignmentFont]          VARCHAR (50)  NULL,
    [LetterAssignmentFontIsBold]    BIT           NULL,
    CONSTRAINT [PK_CPRefClientRelationshipTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefClientRelationshipTypeAudit]
    ON [dbo].[CPRefClientRelationshipTypeAudit]([pkCPRefClientRelationshipType] ASC);


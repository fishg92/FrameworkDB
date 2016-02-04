CREATE TABLE [dbo].[JoinSmartViewDocumentTypeAudit] (
    [pk]                          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME      NULL,
    [AuditEndDate]                DATETIME      NULL,
    [AuditUser]                   VARCHAR (50)  NULL,
    [AuditMachine]                VARCHAR (15)  NULL,
    [AuditDeleted]                TINYINT       NULL,
    [pkJoinSmartViewDocumentType] DECIMAL (18)  NOT NULL,
    [NumberOfDisplayedDocs]       INT           CONSTRAINT [DF__JoinSmart__Numbe__56D7066E] DEFAULT ((0)) NOT NULL,
    [NumberOfDaysToDisplay]       DECIMAL (18)  CONSTRAINT [DF__JoinSmart__Numbe__57CB2AA7] DEFAULT ((0)) NOT NULL,
    [fkSmartView]                 DECIMAL (18)  NOT NULL,
    [fkDocumentType]              VARCHAR (255) NULL,
    [IncludeInSmartView]          BIT           NOT NULL,
    [NumberOfMonthsToDisplay]     INT           CONSTRAINT [DF_JoinSmartViewDocumentTypeAudit_NUmberOfMonthsToDisplay] DEFAULT ((0)) NOT NULL,
    [NumberOfYearsToDisplay]      INT           CONSTRAINT [DF_JoinSmartViewDocumentTypeAudit_NumberOfYearsToDisplay] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinSmartViewDocumentTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinSmartViewDocumentTypeAudit]
    ON [dbo].[JoinSmartViewDocumentTypeAudit]([pkJoinSmartViewDocumentType] ASC);


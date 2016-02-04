CREATE TABLE [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit] (
    [pk]                                                    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                                        DATETIME     NULL,
    [AuditEndDate]                                          DATETIME     NULL,
    [AuditUser]                                             VARCHAR (50) NULL,
    [AuditMachine]                                          VARCHAR (15) NULL,
    [AuditDeleted]                                          TINYINT      NULL,
    [pkFormJoinFormStaticKeywordNameFormStaticKeywordValue] DECIMAL (18) NOT NULL,
    [fkFormStaticKeywordName]                               DECIMAL (18) NOT NULL,
    [fkFormStaticKeywordValue]                              DECIMAL (18) NOT NULL,
    [fkFormName]                                            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinFormStaticKeywordNameFormStaticKeywordValueAudit]
    ON [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit]([pkFormJoinFormStaticKeywordNameFormStaticKeywordValue] ASC);


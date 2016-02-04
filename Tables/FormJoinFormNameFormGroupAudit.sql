CREATE TABLE [dbo].[FormJoinFormNameFormGroupAudit] (
    [pk]                                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                    DATETIME     NULL,
    [AuditEndDate]                      DATETIME     NULL,
    [AuditUser]                         VARCHAR (50) NULL,
    [AuditMachine]                      VARCHAR (15) NULL,
    [AuditDeleted]                      TINYINT      NULL,
    [pkFormJoinFormNameFormGroup]       DECIMAL (18) NOT NULL,
    [fkFormGroup]                       DECIMAL (18) NOT NULL,
    [fkFormName]                        DECIMAL (18) NOT NULL,
    [fkFormJoinFormNameFormGroupParent] DECIMAL (18) NOT NULL,
    [fkFormGroupFormCaption]            DECIMAL (18) NOT NULL,
    [Copies]                            INT          NOT NULL,
    [FormOrder]                         INT          NOT NULL,
    CONSTRAINT [PK_FormJoinFormNameFormGroupAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinFormNameFormGroupAudit]
    ON [dbo].[FormJoinFormNameFormGroupAudit]([pkFormJoinFormNameFormGroup] ASC);


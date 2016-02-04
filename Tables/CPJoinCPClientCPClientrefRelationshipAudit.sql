CREATE TABLE [dbo].[CPJoinCPClientCPClientrefRelationshipAudit] (
    [pk]                                      DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                          DATETIME     NULL,
    [AuditEndDate]                            DATETIME     NULL,
    [AuditUser]                               VARCHAR (50) NULL,
    [AuditMachine]                            VARCHAR (15) NULL,
    [AuditDeleted]                            TINYINT      NULL,
    [pkCPJoinCPClientCPClientrefRelationship] DECIMAL (18) NOT NULL,
    [fkCPClientParent]                        DECIMAL (18) NULL,
    [fkCPClientChild]                         DECIMAL (18) NULL,
    [fkParentCPrefClientRelationshipType]     DECIMAL (18) NULL,
    [fkChildCPrefClientRelationshipType]      DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinCPClientCPClientrefRelationshipAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinCPClientCPClientrefRelationshipAudit]
    ON [dbo].[CPJoinCPClientCPClientrefRelationshipAudit]([pkCPJoinCPClientCPClientrefRelationship] ASC);


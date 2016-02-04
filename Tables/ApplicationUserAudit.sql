CREATE TABLE [dbo].[ApplicationUserAudit] (
    [pk]                DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME       NULL,
    [AuditEndDate]      DATETIME       NULL,
    [AuditUser]         VARCHAR (50)   NULL,
    [AuditMachine]      VARCHAR (15)   NULL,
    [AuditDeleted]      TINYINT        NULL,
    [pkApplicationUser] DECIMAL (18)   NOT NULL,
    [UserName]          VARCHAR (50)   NULL,
    [FirstName]         VARCHAR (50)   NULL,
    [LastName]          VARCHAR (50)   NULL,
    [Password]          VARCHAR (100)  NULL,
    [fkDepartment]      DECIMAL (18)   NULL,
    [WorkerNumber]      VARCHAR (50)   NULL,
    [LDAPUser]          BIT            NULL,
    [LDAPUniqueID]      VARCHAR (100)  NULL,
    [CountyCode]        VARCHAR (50)   CONSTRAINT [DF__Applicati__Count__3793653F] DEFAULT ('') NULL,
    [MiddleName]        VARCHAR (50)   NULL,
    [eMail]             VARCHAR (50)   NULL,
    [IsCaseworker]      BIT            CONSTRAINT [DF__Applicati__IsCas__38878978] DEFAULT ((1)) NULL,
    [IsActive]          BIT            NULL,
    [eCAFFirstName]     VARCHAR (50)   NULL,
    [eCAFLastName]      VARCHAR (50)   NULL,
    [StateID]           VARCHAR (50)   NULL,
    [PhoneNumber]       VARCHAR (10)   NULL,
    [Extension]         VARCHAR (10)   NULL,
    [ExternalIDNumber]  NVARCHAR (150) NULL,
    CONSTRAINT [PK_ApplicationUserAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkApplicationUserAudit]
    ON [dbo].[ApplicationUserAudit]([pkApplicationUser] ASC);


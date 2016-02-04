CREATE TABLE [dbo].[FormNameAudit] (
    [pk]                     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME      NULL,
    [AuditEndDate]           DATETIME      NULL,
    [AuditUser]              VARCHAR (50)  NULL,
    [AuditMachine]           VARCHAR (15)  NULL,
    [AuditDeleted]           TINYINT       NULL,
    [pkFormName]             DECIMAL (18)  NOT NULL,
    [FriendlyName]           VARCHAR (255) NULL,
    [SystemName]             VARCHAR (255) NULL,
    [NotToDMS]               TINYINT       NOT NULL,
    [Renditions]             TINYINT       NOT NULL,
    [Status]                 TINYINT       NOT NULL,
    [BarcodeDocType]         VARCHAR (50)  NULL,
    [BarcodeDocTypeName]     VARCHAR (255) NULL,
    [FormDocType]            VARCHAR (50)  NULL,
    [HasBarcode]             BIT           NULL,
    [BarcodeRequired]        INT           NULL,
    [RouteDocument]          SMALLINT      NULL,
    [ForceSubmitOnFavorite]  BIT           NULL,
    [RequireClientSignature] BIT           NULL,
    [SingleUseDocType]       VARCHAR (50)  NULL,
    [SingleUseDocTypeName]   VARCHAR (255) NULL,
    [DefaultFollowUpDays]    INT           NULL,
    [CompressionWarning]     BIT           NULL,
    [PrintRequired]          INT           NULL,
    CONSTRAINT [PK_FormNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormNameAudit]
    ON [dbo].[FormNameAudit]([pkFormName] ASC);


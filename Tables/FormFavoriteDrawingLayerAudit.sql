CREATE TABLE [dbo].[FormFavoriteDrawingLayerAudit] (
    [AuditId]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME2 (7) NULL,
    [AuditEndDate]   DATETIME2 (7) NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   BIT           NULL,
    [Id]             BIGINT        NOT NULL,
    [FavoriteId]     BIGINT        NOT NULL,
    [PageNumber]     INT           NOT NULL,
    CONSTRAINT [PK_FormFavoriteDrawingLayerAudit] PRIMARY KEY CLUSTERED ([AuditId] ASC)
);


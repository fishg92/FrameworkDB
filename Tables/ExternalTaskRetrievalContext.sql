CREATE TABLE [dbo].[ExternalTaskRetrievalContext] (
    [pkExternalTaskRetrievalContext] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkExternalTask]                 VARCHAR (50) NOT NULL,
    [RetrievalUser]                  DECIMAL (18) NOT NULL,
    [RetrievalDate]                  DATETIME     CONSTRAINT [DF_ExternalTaskRetrievalContext_RetrievalDate] DEFAULT (getdate()) NOT NULL,
    [AuthenticationToken]            VARCHAR (75) CONSTRAINT [DF_ExternalTaskRetrievalContext_AuthenticationToken] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_ExternalTaskRetrievalContext] PRIMARY KEY CLUSTERED ([pkExternalTaskRetrievalContext] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkExternalTask_LoggedInUser]
    ON [dbo].[ExternalTaskRetrievalContext]([fkExternalTask] ASC, [AuthenticationToken] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table storing information to retrieve external task information', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskRetrievalContext';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskRetrievalContext', @level2type = N'COLUMN', @level2name = N'pkExternalTaskRetrievalContext';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key representing the external task (references an external system''s key)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskRetrievalContext', @level2type = N'COLUMN', @level2name = N'fkExternalTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID of the user that retrieved the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskRetrievalContext', @level2type = N'COLUMN', @level2name = N'RetrievalUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that the task was retrieved from the external system.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskRetrievalContext', @level2type = N'COLUMN', @level2name = N'RetrievalDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Authentication token validating the request', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskRetrievalContext', @level2type = N'COLUMN', @level2name = N'AuthenticationToken';


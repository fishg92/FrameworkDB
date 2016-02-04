CREATE TABLE [dbo].[refTaskPriority] (
    [pkrefTaskPriority] DECIMAL (18) NOT NULL,
    [Description]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_refTaskPriority] PRIMARY KEY CLUSTERED ([pkrefTaskPriority] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Description_Unique]
    ON [dbo].[refTaskPriority]([Description] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table lists task priorities. It is tied to an enumeration in the Compass Pilot application and should not be edited.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskPriority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskPriority', @level2type = N'COLUMN', @level2name = N'pkrefTaskPriority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the task priority.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskPriority', @level2type = N'COLUMN', @level2name = N'Description';


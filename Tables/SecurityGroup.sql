CREATE TABLE [dbo].[SecurityGroup] (
    [pkSecurityGroup]     DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [Description]         VARCHAR (255)  NOT NULL,
    [DetailedDescription] VARCHAR (2500) NOT NULL,
    CONSTRAINT [PK_SecurityGroup] PRIMARY KEY CLUSTERED ([pkSecurityGroup] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'An apparently deprecated table to handle security groups before roles were enacted.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SecurityGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SecurityGroup', @level2type = N'COLUMN', @level2name = N'pkSecurityGroup';


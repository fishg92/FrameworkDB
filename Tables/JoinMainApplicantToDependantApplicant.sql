CREATE TABLE [dbo].[JoinMainApplicantToDependantApplicant] (
    [pkJoinMainApplicantToDependantApplicant] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkBenefitApplicationUser]                DECIMAL (18) NULL,
    [fkDependantBenefitApplicationUser]       DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinMainApplicantToDependantApplicant] PRIMARY KEY CLUSTERED ([pkJoinMainApplicantToDependantApplicant] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinMainApplicantToDependantApplicant', @level2type = N'COLUMN', @level2name = N'pkJoinMainApplicantToDependantApplicant';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinMainApplicantToDependantApplicant', @level2type = N'COLUMN', @level2name = N'fkBenefitApplicationUser';


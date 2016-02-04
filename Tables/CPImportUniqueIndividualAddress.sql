CREATE TABLE [dbo].[CPImportUniqueIndividualAddress] (
    [pkCPImportUniqueIndividualAddress] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [IndividualID]                      VARCHAR (50) NULL,
    [Street1]                           VARCHAR (50) NULL,
    [Street2]                           VARCHAR (50) NULL,
    [City]                              VARCHAR (50) NULL,
    [State]                             VARCHAR (50) NULL,
    [Zip]                               VARCHAR (5)  NULL,
    CONSTRAINT [PK_CPImportUniqueIndividualAddress] PRIMARY KEY CLUSTERED ([pkCPImportUniqueIndividualAddress] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ixCPImportUniqueIndividualAddressIndividualID]
    ON [dbo].[CPImportUniqueIndividualAddress]([IndividualID] ASC);


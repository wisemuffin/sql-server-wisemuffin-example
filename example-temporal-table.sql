/*  *******************************************************
*   setting up history table
*   *******************************************************
*/

CREATE SCHEMA History;
GO

ALTER TABLE HumanResources.Department
    ADD
        ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
            CONSTRAINT DF_InsurancePolicy_ValidFrom DEFAULT SYSUTCDATETIME()
      , ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
            CONSTRAINT DF_InsurancePolicy_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
      , PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);
GO

ALTER TABLE HumanResources.Department
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.Department));
;

/*  *******************************************************
*   reviewing history table
*   *******************************************************
*/

SELECT TOP (1000) 
      *
FROM [HumanResources].[Department]
;
update [HumanResources].[Department]  set groupname = 'Ooops' where GroupName = 'Inventory Management'
;
select * from History.Department
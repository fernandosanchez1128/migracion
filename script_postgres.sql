CREATE DATABASE "AdventureWorksDW2014";


CREATE TABLE "public"."AdventureWorksDWBuildVersion"
(
	"DBVersion" character varying(100),
	"VersionDate" timestamp with time zone
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DatabaseLog"
(
	"DatabaseLogID" serial NOT NULL,
	"PostTime" timestamp with time zone NOT NULL,
	"DatabaseUser" character varying(256) NOT NULL,
	"Event" character varying(256) NOT NULL,
	"Schema" character varying(256),
	"Object" character varying(256),
	"TSQL" character varying NOT NULL,
	"XmlEvent" xml NOT NULL,
	CONSTRAINT "PK_DatabaseLog_DatabaseLogID_DatabaseLog" PRIMARY KEY ("DatabaseLogID")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimAccount"
(
	"AccountKey" serial NOT NULL,
	"ParentAccountKey" integer,
	"AccountCodeAlternateKey" integer,
	"ParentAccountCodeAlternateKey" integer,
	"AccountDescription" character varying(100),
	"AccountType" character varying(100),
	"Operator" character varying(100),
	"CustomMembers" character varying(600),
	"ValueType" character varying(100),
	"CustomMemberOptions" character varying(400),
	CONSTRAINT "PK_DimAccount_DimAccount" PRIMARY KEY ("AccountKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimCurrency"
(
	"CurrencyKey" serial NOT NULL,
	"CurrencyAlternateKey" character(6) NOT NULL,
	"CurrencyName" character varying(100) NOT NULL,
	CONSTRAINT "PK_DimCurrency_CurrencyKey_DimCurrency" PRIMARY KEY ("CurrencyKey")
)
WITH
(
	OIDS = FALSE
);
CREATE UNIQUE INDEX "AK_DimCurrency_CurrencyAlternateKey_DimCurrency" ON "public"."DimCurrency"
 USING btree
(
	"CurrencyAlternateKey" ASC
) TABLESPACE pg_default;


CREATE TABLE "public"."DimCustomer"
(
	"CustomerKey" serial NOT NULL,
	"GeographyKey" integer,
	"CustomerAlternateKey" character varying(30) NOT NULL,
	"Title" character varying(16),
	"FirstName" character varying(100),
	"MiddleName" character varying(100),
	"LastName" character varying(100),
	"NameStyle" character(1),
	"BirthDate" date,
	"MaritalStatus" character(2),
	"Suffix" character varying(20),
	"Gender" character varying(2),
	"EmailAddress" character varying(100),
	"YearlyIncome" numeric(18,6),
	"TotalChildren" smallint,
	"NumberChildrenAtHome" smallint,
	"EnglishEducation" character varying(80),
	"SpanishEducation" character varying(80),
	"FrenchEducation" character varying(80),
	"EnglishOccupation" character varying(200),
	"SpanishOccupation" character varying(200),
	"FrenchOccupation" character varying(200),
	"HouseOwnerFlag" character(2),
	"NumberCarsOwned" smallint,
	"AddressLine1" character varying(240),
	"AddressLine2" character varying(240),
	"Phone" character varying(40),
	"DateFirstPurchase" date,
	"CommuteDistance" character varying(30),
	CONSTRAINT "PK_DimCustomer_CustomerKey_DimCustomer" PRIMARY KEY ("CustomerKey")
)
WITH
(
	OIDS = FALSE
);
CREATE UNIQUE INDEX "IX_DimCustomer_CustomerAlternateKey_DimCustomer" ON "public"."DimCustomer"
 USING btree
(
	"CustomerAlternateKey" ASC
) TABLESPACE pg_default;


CREATE TABLE "public"."DimDate"
(
	"DateKey" integer NOT NULL,
	"FullDateAlternateKey" date NOT NULL,
	"DayNumberOfWeek" smallint NOT NULL,
	"EnglishDayNameOfWeek" character varying(20) NOT NULL,
	"SpanishDayNameOfWeek" character varying(20) NOT NULL,
	"FrenchDayNameOfWeek" character varying(20) NOT NULL,
	"DayNumberOfMonth" smallint NOT NULL,
	"DayNumberOfYear" smallint NOT NULL,
	"WeekNumberOfYear" smallint NOT NULL,
	"EnglishMonthName" character varying(20) NOT NULL,
	"SpanishMonthName" character varying(20) NOT NULL,
	"FrenchMonthName" character varying(20) NOT NULL,
	"MonthNumberOfYear" smallint NOT NULL,
	"CalendarQuarter" smallint NOT NULL,
	"CalendarYear" smallint NOT NULL,
	"CalendarSemester" smallint NOT NULL,
	"FiscalQuarter" smallint NOT NULL,
	"FiscalYear" smallint NOT NULL,
	"FiscalSemester" smallint NOT NULL,
	CONSTRAINT "PK_DimDate_DateKey_DimDate" PRIMARY KEY ("DateKey")
)
WITH
(
	OIDS = FALSE
);
CREATE UNIQUE INDEX "AK_DimDate_FullDateAlternateKey_DimDate" ON "public"."DimDate"
 USING btree
(
	"FullDateAlternateKey" ASC
) TABLESPACE pg_default;


CREATE TABLE "public"."DimDepartmentGroup"
(
	"DepartmentGroupKey" serial NOT NULL,
	"ParentDepartmentGroupKey" integer,
	"DepartmentGroupName" character varying(100),
	CONSTRAINT "PK_DimDepartmentGroup_DimDepartmentGroup" PRIMARY KEY ("DepartmentGroupKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimEmployee"
(
	"EmployeeKey" serial NOT NULL,
	"ParentEmployeeKey" integer,
	"EmployeeNationalIDAlternateKey" character varying(30),
	"ParentEmployeeNationalIDAlternateKey" character varying(30),
	"SalesTerritoryKey" integer,
	"FirstName" character varying(100) NOT NULL,
	"LastName" character varying(100) NOT NULL,
	"MiddleName" character varying(100),
	"NameStyle" character(1) NOT NULL,
	"Title" character varying(100),
	"HireDate" date,
	"BirthDate" date,
	"LoginID" character varying(512),
	"EmailAddress" character varying(100),
	"Phone" character varying(50),
	"MaritalStatus" character(2),
	"EmergencyContactName" character varying(100),
	"EmergencyContactPhone" character varying(50),
	"SalariedFlag" character(1),
	"Gender" character(2),
	"PayFrequency" smallint,
	"BaseRate" numeric(18,6),
	"VacationHours" smallint,
	"SickLeaveHours" smallint,
	"CurrentFlag" character(1) NOT NULL,
	"SalesPersonFlag" character(1) NOT NULL,
	"DepartmentName" character varying(100),
	"StartDate" date,
	"EndDate" date,
	"Status" character varying(100),
	"EmployeePhoto" bytea,
	CONSTRAINT "PK_DimEmployee_EmployeeKey_DimEmployee" PRIMARY KEY ("EmployeeKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimGeography"
(
	"GeographyKey" serial NOT NULL,
	"City" character varying(60),
	"StateProvinceCode" character varying(6),
	"StateProvinceName" character varying(100),
	"CountryRegionCode" character varying(6),
	"EnglishCountryRegionName" character varying(100),
	"SpanishCountryRegionName" character varying(100),
	"FrenchCountryRegionName" character varying(100),
	"PostalCode" character varying(30),
	"SalesTerritoryKey" integer,
	"IpAddressLocator" character varying(30),
	CONSTRAINT "PK_DimGeography_GeographyKey_DimGeography" PRIMARY KEY ("GeographyKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimOrganization"
(
	"OrganizationKey" serial NOT NULL,
	"ParentOrganizationKey" integer,
	"PercentageOfOwnership" character varying(32),
	"OrganizationName" character varying(100),
	"CurrencyKey" integer,
	CONSTRAINT "PK_DimOrganization_DimOrganization" PRIMARY KEY ("OrganizationKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimProduct"
(
	"ProductKey" serial NOT NULL,
	"ProductAlternateKey" character varying(50),
	"ProductSubcategoryKey" integer,
	"WeightUnitMeasureCode" character(6),
	"SizeUnitMeasureCode" character(6),
	"EnglishProductName" character varying(100) NOT NULL,
	"SpanishProductName" character varying(100) NOT NULL,
	"FrenchProductName" character varying(100) NOT NULL,
	"StandardCost" numeric(18,6),
	"FinishedGoodsFlag" character(1) NOT NULL,
	"Color" character varying(30) NOT NULL,
	"SafetyStockLevel" smallint,
	"ReorderPoint" smallint,
	"ListPrice" numeric(18,6),
	"Size" character varying(100),
	"SizeRange" character varying(100),
	"Weight" double precision,
	"DaysToManufacture" integer,
	"ProductLine" character(4),
	"DealerPrice" numeric(18,6),
	"Class" character(4),
	"Style" character(4),
	"ModelName" character varying(100),
	"LargePhoto" bytea,
	"EnglishDescription" character varying(800),
	"FrenchDescription" character varying(800),
	"ChineseDescription" character varying(800),
	"ArabicDescription" character varying(800),
	"HebrewDescription" character varying(800),
	"ThaiDescription" character varying(800),
	"GermanDescription" character varying(800),
	"JapaneseDescription" character varying(800),
	"TurkishDescription" character varying(800),
	"StartDate" timestamp with time zone,
	"EndDate" timestamp with time zone,
	"Status" character varying(14),
	CONSTRAINT "PK_DimProduct_ProductKey_DimProduct" PRIMARY KEY ("ProductKey"),
	CONSTRAINT "AK_DimProduct_ProductAlternateKey_StartDate_DimProduct" UNIQUE ("ProductAlternateKey","StartDate")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimProductCategory"
(
	"ProductCategoryKey" serial NOT NULL,
	"ProductCategoryAlternateKey" integer,
	"EnglishProductCategoryName" character varying(100) NOT NULL,
	"SpanishProductCategoryName" character varying(100) NOT NULL,
	"FrenchProductCategoryName" character varying(100) NOT NULL,
	CONSTRAINT "PK_DimProductCategory_ProductCategoryKey_DimProductCategory" PRIMARY KEY ("ProductCategoryKey"),
	CONSTRAINT "AK_DimProductCategory_ProductCategoryAlternateKey_DimProductCat" UNIQUE ("ProductCategoryAlternateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimProductSubcategory"
(
	"ProductSubcategoryKey" serial NOT NULL,
	"ProductSubcategoryAlternateKey" integer,
	"EnglishProductSubcategoryName" character varying(100) NOT NULL,
	"SpanishProductSubcategoryName" character varying(100) NOT NULL,
	"FrenchProductSubcategoryName" character varying(100) NOT NULL,
	"ProductCategoryKey" integer,
	CONSTRAINT "PK_DimProductSubcategory_ProductSubcategoryKey_DimProductSubcat" PRIMARY KEY ("ProductSubcategoryKey"),
	CONSTRAINT "AK_DimProductSubcategory_ProductSubcategoryAlternateKey_DimProd" UNIQUE ("ProductSubcategoryAlternateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimPromotion"
(
	"PromotionKey" serial NOT NULL,
	"PromotionAlternateKey" integer,
	"EnglishPromotionName" character varying(510),
	"SpanishPromotionName" character varying(510),
	"FrenchPromotionName" character varying(510),
	"DiscountPct" double precision,
	"EnglishPromotionType" character varying(100),
	"SpanishPromotionType" character varying(100),
	"FrenchPromotionType" character varying(100),
	"EnglishPromotionCategory" character varying(100),
	"SpanishPromotionCategory" character varying(100),
	"FrenchPromotionCategory" character varying(100),
	"StartDate" timestamp with time zone NOT NULL,
	"EndDate" timestamp with time zone,
	"MinQty" integer,
	"MaxQty" integer,
	CONSTRAINT "PK_DimPromotion_PromotionKey_DimPromotion" PRIMARY KEY ("PromotionKey"),
	CONSTRAINT "AK_DimPromotion_PromotionAlternateKey_DimPromotion" UNIQUE ("PromotionAlternateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimReseller"
(
	"ResellerKey" serial NOT NULL,
	"GeographyKey" integer,
	"ResellerAlternateKey" character varying(30),
	"Phone" character varying(50),
	"BusinessType" character varying(20) NOT NULL,
	"ResellerName" character varying(100) NOT NULL,
	"NumberEmployees" integer,
	"OrderFrequency" character(1),
	"OrderMonth" smallint,
	"FirstOrderYear" integer,
	"LastOrderYear" integer,
	"ProductLine" character varying(100),
	"AddressLine1" character varying(120),
	"AddressLine2" character varying(120),
	"AnnualSales" numeric(18,6),
	"BankName" character varying(100),
	"MinPaymentType" smallint,
	"MinPaymentAmount" numeric(18,6),
	"AnnualRevenue" numeric(18,6),
	"YearOpened" integer,
	CONSTRAINT "PK_DimReseller_ResellerKey_DimReseller" PRIMARY KEY ("ResellerKey"),
	CONSTRAINT "AK_DimReseller_ResellerAlternateKey_DimReseller" UNIQUE ("ResellerAlternateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimSalesReason"
(
	"SalesReasonKey" serial NOT NULL,
	"SalesReasonAlternateKey" integer NOT NULL,
	"SalesReasonName" character varying(100) NOT NULL,
	"SalesReasonReasonType" character varying(100) NOT NULL,
	CONSTRAINT "PK_DimSalesReason_SalesReasonKey_DimSalesReason" PRIMARY KEY ("SalesReasonKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimSalesTerritory"
(
	"SalesTerritoryKey" serial NOT NULL,
	"SalesTerritoryAlternateKey" integer,
	"SalesTerritoryRegion" character varying(100) NOT NULL,
	"SalesTerritoryCountry" character varying(100) NOT NULL,
	"SalesTerritoryGroup" character varying(100),
	"SalesTerritoryImage" bytea,
	CONSTRAINT "PK_DimSalesTerritory_SalesTerritoryKey_DimSalesTerritory" PRIMARY KEY ("SalesTerritoryKey"),
	CONSTRAINT "AK_DimSalesTerritory_SalesTerritoryAlternateKey_DimSalesTerrito" UNIQUE ("SalesTerritoryAlternateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."DimScenario"
(
	"ScenarioKey" serial NOT NULL,
	"ScenarioName" character varying(100),
	CONSTRAINT "PK_DimScenario_DimScenario" PRIMARY KEY ("ScenarioKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactAdditionalInternationalProductDescription"
(
	"ProductKey" integer NOT NULL,
	"CultureName" character varying(100) NOT NULL,
	"ProductDescription" character varying NOT NULL,
	CONSTRAINT "PK_FactAdditionalInternationalProductDescription_ProductKey_Cul" PRIMARY KEY ("ProductKey","CultureName")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactCallCenter"
(
	"FactCallCenterID" serial NOT NULL,
	"DateKey" integer NOT NULL,
	"WageType" character varying(30) NOT NULL,
	"Shift" character varying(40) NOT NULL,
	"LevelOneOperators" smallint NOT NULL,
	"LevelTwoOperators" smallint NOT NULL,
	"TotalOperators" smallint NOT NULL,
	"Calls" integer NOT NULL,
	"AutomaticResponses" integer NOT NULL,
	"Orders" integer NOT NULL,
	"IssuesRaised" smallint NOT NULL,
	"AverageTimePerIssue" smallint NOT NULL,
	"ServiceGrade" double precision NOT NULL,
	"Date" timestamp with time zone,
	CONSTRAINT "PK_FactCallCenter_FactCallCenterID_FactCallCenter" PRIMARY KEY ("FactCallCenterID"),
	CONSTRAINT "AK_FactCallCenter_DateKey_Shift_FactCallCenter" UNIQUE ("DateKey","Shift")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactCurrencyRate"
(
	"CurrencyKey" integer NOT NULL,
	"DateKey" integer NOT NULL,
	"AverageRate" double precision NOT NULL,
	"EndOfDayRate" double precision NOT NULL,
	"Date" timestamp with time zone,
	CONSTRAINT "PK_FactCurrencyRate_CurrencyKey_DateKey_FactCurrencyRate" PRIMARY KEY ("CurrencyKey","DateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactFinance"
(
	"FinanceKey" serial NOT NULL,
	"DateKey" integer NOT NULL,
	"OrganizationKey" integer NOT NULL,
	"DepartmentGroupKey" integer NOT NULL,
	"ScenarioKey" integer NOT NULL,
	"AccountKey" integer NOT NULL,
	"Amount" double precision NOT NULL,
	"Date" timestamp with time zone
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactInternetSales"
(
	"ProductKey" integer NOT NULL,
	"OrderDateKey" integer NOT NULL,
	"DueDateKey" integer NOT NULL,
	"ShipDateKey" integer NOT NULL,
	"CustomerKey" integer NOT NULL,
	"PromotionKey" integer NOT NULL,
	"CurrencyKey" integer NOT NULL,
	"SalesTerritoryKey" integer NOT NULL,
	"SalesOrderNumber" character varying(40) NOT NULL,
	"SalesOrderLineNumber" smallint NOT NULL,
	"RevisionNumber" smallint NOT NULL,
	"OrderQuantity" smallint NOT NULL,
	"UnitPrice" numeric(18,6) NOT NULL,
	"ExtendedAmount" numeric(18,6) NOT NULL,
	"UnitPriceDiscountPct" double precision NOT NULL,
	"DiscountAmount" double precision NOT NULL,
	"ProductStandardCost" numeric(18,6) NOT NULL,
	"TotalProductCost" numeric(18,6) NOT NULL,
	"SalesAmount" numeric(18,6) NOT NULL,
	"TaxAmt" numeric(18,6) NOT NULL,
	"Freight" numeric(18,6) NOT NULL,
	"CarrierTrackingNumber" character varying(50),
	"CustomerPONumber" character varying(50),
	"OrderDate" timestamp with time zone,
	"DueDate" timestamp with time zone,
	"ShipDate" timestamp with time zone,
	CONSTRAINT "PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber_Fact" PRIMARY KEY ("SalesOrderNumber","SalesOrderLineNumber")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactInternetSalesReason"
(
	"SalesOrderNumber" character varying(40) NOT NULL,
	"SalesOrderLineNumber" smallint NOT NULL,
	"SalesReasonKey" integer NOT NULL,
	CONSTRAINT "PK_FactInternetSalesReason_SalesOrderNumber_SalesOrderLineNumbe" PRIMARY KEY ("SalesOrderNumber","SalesOrderLineNumber","SalesReasonKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactProductInventory"
(
	"ProductKey" integer NOT NULL,
	"DateKey" integer NOT NULL,
	"MovementDate" date NOT NULL,
	"UnitCost" numeric(18,6) NOT NULL,
	"UnitsIn" integer NOT NULL,
	"UnitsOut" integer NOT NULL,
	"UnitsBalance" integer NOT NULL,
	CONSTRAINT "PK_FactProductInventory_FactProductInventory" PRIMARY KEY ("ProductKey","DateKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactResellerSales"
(
	"ProductKey" integer NOT NULL,
	"OrderDateKey" integer NOT NULL,
	"DueDateKey" integer NOT NULL,
	"ShipDateKey" integer NOT NULL,
	"ResellerKey" integer NOT NULL,
	"EmployeeKey" integer NOT NULL,
	"PromotionKey" integer NOT NULL,
	"CurrencyKey" integer NOT NULL,
	"SalesTerritoryKey" integer NOT NULL,
	"SalesOrderNumber" character varying(40) NOT NULL,
	"SalesOrderLineNumber" smallint NOT NULL,
	"RevisionNumber" smallint,
	"OrderQuantity" smallint,
	"UnitPrice" numeric(18,6),
	"ExtendedAmount" numeric(18,6),
	"UnitPriceDiscountPct" double precision,
	"DiscountAmount" double precision,
	"ProductStandardCost" numeric(18,6),
	"TotalProductCost" numeric(18,6),
	"SalesAmount" numeric(18,6),
	"TaxAmt" numeric(18,6),
	"Freight" numeric(18,6),
	"CarrierTrackingNumber" character varying(50),
	"CustomerPONumber" character varying(50),
	"OrderDate" timestamp with time zone,
	"DueDate" timestamp with time zone,
	"ShipDate" timestamp with time zone,
	CONSTRAINT "PK_FactResellerSales_SalesOrderNumber_SalesOrderLineNumber_Fact" PRIMARY KEY ("SalesOrderNumber","SalesOrderLineNumber")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactSalesQuota"
(
	"SalesQuotaKey" serial NOT NULL,
	"EmployeeKey" integer NOT NULL,
	"DateKey" integer NOT NULL,
	"CalendarYear" smallint NOT NULL,
	"CalendarQuarter" smallint NOT NULL,
	"SalesAmountQuota" numeric(18,6) NOT NULL,
	"Date" timestamp with time zone,
	CONSTRAINT "PK_FactSalesQuota_SalesQuotaKey_FactSalesQuota" PRIMARY KEY ("SalesQuotaKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."FactSurveyResponse"
(
	"SurveyResponseKey" serial NOT NULL,
	"DateKey" integer NOT NULL,
	"CustomerKey" integer NOT NULL,
	"ProductCategoryKey" integer NOT NULL,
	"EnglishProductCategoryName" character varying(100) NOT NULL,
	"ProductSubcategoryKey" integer NOT NULL,
	"EnglishProductSubcategoryName" character varying(100) NOT NULL,
	"Date" timestamp with time zone,
	CONSTRAINT "PK_FactSurveyResponse_SurveyResponseKey_FactSurveyResponse" PRIMARY KEY ("SurveyResponseKey")
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."NewFactCurrencyRate"
(
	"AverageRate" real,
	"CurrencyID" character varying(6),
	"CurrencyDate" date,
	"EndOfDayRate" real,
	"CurrencyKey" integer,
	"DateKey" integer
)
WITH
(
	OIDS = FALSE
);

CREATE TABLE "public"."ProspectiveBuyer"
(
	"ProspectiveBuyerKey" serial NOT NULL,
	"ProspectAlternateKey" character varying(30),
	"FirstName" character varying(100),
	"MiddleName" character varying(100),
	"LastName" character varying(100),
	"BirthDate" timestamp with time zone,
	"MaritalStatus" character(2),
	"Gender" character varying(2),
	"EmailAddress" character varying(100),
	"YearlyIncome" numeric(18,6),
	"TotalChildren" smallint,
	"NumberChildrenAtHome" smallint,
	"Education" character varying(80),
	"Occupation" character varying(200),
	"HouseOwnerFlag" character(2),
	"NumberCarsOwned" smallint,
	"AddressLine1" character varying(240),
	"AddressLine2" character varying(240),
	"City" character varying(60),
	"StateProvinceCode" character varying(6),
	"PostalCode" character varying(30),
	"Phone" character varying(40),
	"Salutation" character varying(16),
	"Unknown" integer,
	CONSTRAINT "PK_ProspectiveBuyer_ProspectiveBuyerKey_ProspectiveBuyer" PRIMARY KEY ("ProspectiveBuyerKey")
)
WITH
(
	OIDS = FALSE
);
ALTER TABLE "public"."DimAccount" ADD CONSTRAINT "FK_DimAccount_DimAccount_DimAccount" FOREIGN KEY ("ParentAccountKey") REFERENCES "public"."DimAccount" ("AccountKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimCustomer" ADD CONSTRAINT "FK_DimCustomer_DimGeography_DimCustomer" FOREIGN KEY ("GeographyKey") REFERENCES "public"."DimGeography" ("GeographyKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimDepartmentGroup" ADD CONSTRAINT "FK_DimDepartmentGroup_DimDepartmentGroup_DimDepartmentGroup" FOREIGN KEY ("ParentDepartmentGroupKey") REFERENCES "public"."DimDepartmentGroup" ("DepartmentGroupKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimEmployee" ADD CONSTRAINT "FK_DimEmployee_DimEmployee_DimEmployee" FOREIGN KEY ("ParentEmployeeKey") REFERENCES "public"."DimEmployee" ("EmployeeKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimEmployee" ADD CONSTRAINT "FK_DimEmployee_DimSalesTerritory_DimEmployee" FOREIGN KEY ("SalesTerritoryKey") REFERENCES "public"."DimSalesTerritory" ("SalesTerritoryKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimGeography" ADD CONSTRAINT "FK_DimGeography_DimSalesTerritory_DimGeography" FOREIGN KEY ("SalesTerritoryKey") REFERENCES "public"."DimSalesTerritory" ("SalesTerritoryKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimOrganization" ADD CONSTRAINT "FK_DimOrganization_DimCurrency_DimOrganization" FOREIGN KEY ("CurrencyKey") REFERENCES "public"."DimCurrency" ("CurrencyKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimOrganization" ADD CONSTRAINT "FK_DimOrganization_DimOrganization_DimOrganization" FOREIGN KEY ("ParentOrganizationKey") REFERENCES "public"."DimOrganization" ("OrganizationKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimProduct" ADD CONSTRAINT "FK_DimProduct_DimProductSubcategory_DimProduct" FOREIGN KEY ("ProductSubcategoryKey") REFERENCES "public"."DimProductSubcategory" ("ProductSubcategoryKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimProductSubcategory" ADD CONSTRAINT "FK_DimProductSubcategory_DimProductCategory_DimProductSubcatego" FOREIGN KEY ("ProductCategoryKey") REFERENCES "public"."DimProductCategory" ("ProductCategoryKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."DimReseller" ADD CONSTRAINT "FK_DimReseller_DimGeography_DimReseller" FOREIGN KEY ("GeographyKey") REFERENCES "public"."DimGeography" ("GeographyKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactCallCenter" ADD CONSTRAINT "FK_FactCallCenter_DimDate_FactCallCenter" FOREIGN KEY ("DateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactCurrencyRate" ADD CONSTRAINT "FK_FactCurrencyRate_DimCurrency_FactCurrencyRate" FOREIGN KEY ("CurrencyKey") REFERENCES "public"."DimCurrency" ("CurrencyKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactCurrencyRate" ADD CONSTRAINT "FK_FactCurrencyRate_DimDate_FactCurrencyRate" FOREIGN KEY ("DateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactFinance" ADD CONSTRAINT "FK_FactFinance_DimAccount_FactFinance" FOREIGN KEY ("AccountKey") REFERENCES "public"."DimAccount" ("AccountKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactFinance" ADD CONSTRAINT "FK_FactFinance_DimDate_FactFinance" FOREIGN KEY ("DateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactFinance" ADD CONSTRAINT "FK_FactFinance_DimDepartmentGroup_FactFinance" FOREIGN KEY ("DepartmentGroupKey") REFERENCES "public"."DimDepartmentGroup" ("DepartmentGroupKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactFinance" ADD CONSTRAINT "FK_FactFinance_DimOrganization_FactFinance" FOREIGN KEY ("OrganizationKey") REFERENCES "public"."DimOrganization" ("OrganizationKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactFinance" ADD CONSTRAINT "FK_FactFinance_DimScenario_FactFinance" FOREIGN KEY ("ScenarioKey") REFERENCES "public"."DimScenario" ("ScenarioKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimCurrency_FactInternetSales" FOREIGN KEY ("CurrencyKey") REFERENCES "public"."DimCurrency" ("CurrencyKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimCustomer_FactInternetSales" FOREIGN KEY ("CustomerKey") REFERENCES "public"."DimCustomer" ("CustomerKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimDate_FactInternetSales" FOREIGN KEY ("OrderDateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimDate1_FactInternetSales" FOREIGN KEY ("DueDateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimDate2_FactInternetSales" FOREIGN KEY ("ShipDateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimProduct_FactInternetSales" FOREIGN KEY ("ProductKey") REFERENCES "public"."DimProduct" ("ProductKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimPromotion_FactInternetSales" FOREIGN KEY ("PromotionKey") REFERENCES "public"."DimPromotion" ("PromotionKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSales" ADD CONSTRAINT "FK_FactInternetSales_DimSalesTerritory_FactInternetSales" FOREIGN KEY ("SalesTerritoryKey") REFERENCES "public"."DimSalesTerritory" ("SalesTerritoryKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSalesReason" ADD CONSTRAINT "FK_FactInternetSalesReason_DimSalesReason_FactInternetSalesReas" FOREIGN KEY ("SalesReasonKey") REFERENCES "public"."DimSalesReason" ("SalesReasonKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactInternetSalesReason" ADD CONSTRAINT "FK_FactInternetSalesReason_FactInternetSales_FactInternetSalesR" FOREIGN KEY ("SalesOrderNumber","SalesOrderLineNumber") REFERENCES "public"."FactInternetSales" ("SalesOrderNumber","SalesOrderLineNumber") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactProductInventory" ADD CONSTRAINT "FK_FactProductInventory_DimDate_FactProductInventory" FOREIGN KEY ("DateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactProductInventory" ADD CONSTRAINT "FK_FactProductInventory_DimProduct_FactProductInventory" FOREIGN KEY ("ProductKey") REFERENCES "public"."DimProduct" ("ProductKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimCurrency_FactResellerSales" FOREIGN KEY ("CurrencyKey") REFERENCES "public"."DimCurrency" ("CurrencyKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimDate_FactResellerSales" FOREIGN KEY ("OrderDateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimDate1_FactResellerSales" FOREIGN KEY ("DueDateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimDate2_FactResellerSales" FOREIGN KEY ("ShipDateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimEmployee_FactResellerSales" FOREIGN KEY ("EmployeeKey") REFERENCES "public"."DimEmployee" ("EmployeeKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimProduct_FactResellerSales" FOREIGN KEY ("ProductKey") REFERENCES "public"."DimProduct" ("ProductKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimPromotion_FactResellerSales" FOREIGN KEY ("PromotionKey") REFERENCES "public"."DimPromotion" ("PromotionKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimReseller_FactResellerSales" FOREIGN KEY ("ResellerKey") REFERENCES "public"."DimReseller" ("ResellerKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactResellerSales" ADD CONSTRAINT "FK_FactResellerSales_DimSalesTerritory_FactResellerSales" FOREIGN KEY ("SalesTerritoryKey") REFERENCES "public"."DimSalesTerritory" ("SalesTerritoryKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactSalesQuota" ADD CONSTRAINT "FK_FactSalesQuota_DimDate_FactSalesQuota" FOREIGN KEY ("DateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactSalesQuota" ADD CONSTRAINT "FK_FactSalesQuota_DimEmployee_FactSalesQuota" FOREIGN KEY ("EmployeeKey") REFERENCES "public"."DimEmployee" ("EmployeeKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactSurveyResponse" ADD CONSTRAINT "FK_FactSurveyResponse_CustomerKey_FactSurveyResponse" FOREIGN KEY ("CustomerKey") REFERENCES "public"."DimCustomer" ("CustomerKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "public"."FactSurveyResponse" ADD CONSTRAINT "FK_FactSurveyResponse_DateKey_FactSurveyResponse" FOREIGN KEY ("DateKey") REFERENCES "public"."DimDate" ("DateKey") MATCH SIMPLE
ON UPDATE NO ACTION ON DELETE NO ACTION;

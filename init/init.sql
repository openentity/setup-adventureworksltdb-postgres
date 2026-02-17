CREATE SCHEMA "SalesLT";

CREATE TABLE "SalesLT"."Address" (
    "AddressID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "AddressLine1" VARCHAR(60) NOT NULL,
    "AddressLine2" VARCHAR(60),
    "City" VARCHAR(30) NOT NULL,
    "StateProvince" VARCHAR(50) NOT NULL,
    "CountryRegion" VARCHAR(50) NOT NULL,
    "PostalCode" VARCHAR(15) NOT NULL,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_Address_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "PK_Address_AddressID" PRIMARY KEY ("AddressID")
);
CREATE INDEX "IX_Address_StateProvince" ON "SalesLT"."Address" ("StateProvince");
CREATE INDEX "IX_Address_Info" ON "SalesLT"."Address" ("AddressLine1", "AddressLine2", "City", "StateProvince", "CountryRegion");
COMMENT ON TABLE "SalesLT"."Address" IS 'Street address information for customers.';
COMMENT ON COLUMN "SalesLT"."Address"."AddressID" IS 'Primary key for Address records.';
COMMENT ON COLUMN "SalesLT"."Address"."AddressLine1" IS 'First street address line.';
COMMENT ON COLUMN "SalesLT"."Address"."AddressLine2" IS 'Second street address line.';
COMMENT ON COLUMN "SalesLT"."Address"."City" IS 'Name of the city.';
COMMENT ON COLUMN "SalesLT"."Address"."StateProvince" IS 'Name of state or province.';
COMMENT ON COLUMN "SalesLT"."Address"."PostalCode" IS 'Postal code for the street address.';
COMMENT ON COLUMN "SalesLT"."Address"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."Address"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_Address_rowguid" ON "SalesLT"."Address" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "PK_Address_AddressID" ON "SalesLT"."Address" IS 'Primary key (clustered) constraint';

CREATE TABLE "SalesLT"."Customer" (
    "CustomerID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "NameStyle" BOOLEAN NOT NULL DEFAULT(FALSE),
    "Title" VARCHAR(8),
    "FirstName" VARCHAR(50),
    "MiddleName" VARCHAR(50),
    "LastName" VARCHAR(50),
    "Suffix" VARCHAR(10),
    "CompanyName" VARCHAR(128),
    "SalesPerson" VARCHAR(256),
    "EmailAddress" VARCHAR(256),
    "Phone" VARCHAR(25),
    "PasswordHash" VARCHAR(128) NOT NULL,
    "PasswordSalt" VARCHAR(10) NOT NULL,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_Customer_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY ("CustomerID")
);
CREATE INDEX "IX_Customer_EmailAddress" ON "SalesLT"."Customer" ("EmailAddress");
COMMENT ON TABLE "SalesLT"."Customer" IS 'Customer information.';
COMMENT ON COLUMN "SalesLT"."Customer"."CustomerID" IS 'Primary key for Customer records.';
COMMENT ON COLUMN "SalesLT"."Customer"."NameStyle" IS '0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.';
COMMENT ON COLUMN "SalesLT"."Customer"."Title" IS 'A courtesy title. For example, Mr. or Ms.';
COMMENT ON COLUMN "SalesLT"."Customer"."FirstName" IS 'First name of the person.';
COMMENT ON COLUMN "SalesLT"."Customer"."MiddleName" IS 'Middle name or middle initial of the person.';
COMMENT ON COLUMN "SalesLT"."Customer"."LastName" IS 'Last name of the person.';
COMMENT ON COLUMN "SalesLT"."Customer"."Suffix" IS 'Surname suffix. For example, Sr. or Jr.';
COMMENT ON COLUMN "SalesLT"."Customer"."CompanyName" IS 'The customer''s organization.';
COMMENT ON COLUMN "SalesLT"."Customer"."SalesPerson" IS 'The customer''s sales person, an employee of AdventureWorks Cycles.';
COMMENT ON COLUMN "SalesLT"."Customer"."EmailAddress" IS 'E-mail address for the person.';
COMMENT ON COLUMN "SalesLT"."Customer"."Phone" IS 'Phone number associated with the person.';
COMMENT ON COLUMN "SalesLT"."Customer"."PasswordHash" IS 'Password for the e-mail account.';
COMMENT ON COLUMN "SalesLT"."Customer"."PasswordSalt" IS 'Random value concatenated with the password string before the password is hashed.';
COMMENT ON COLUMN "SalesLT"."Customer"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."Customer"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_Customer_rowguid" ON "SalesLT"."Customer" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "PK_Customer_CustomerID" ON "SalesLT"."Customer" IS 'Primary key (clustered) constraint';

CREATE TABLE "SalesLT"."CustomerAddress" (
    "CustomerID" INT NOT NULL,
    "AddressID" INT NOT NULL,
    "AddressType" VARCHAR(50) NOT NULL,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_CustomerAddress_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "PK_CustomerAddress_CustomerID_AddressID" PRIMARY KEY ("CustomerID", "AddressID"),
    CONSTRAINT "FK_CustomerAddress_Customer_CustomerID" FOREIGN KEY("CustomerID") REFERENCES "SalesLT"."Customer"("CustomerID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "FK_CustomerAddress_Address_AddressID" FOREIGN KEY("AddressID") REFERENCES "SalesLT"."Address"("AddressID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE "SalesLT"."CustomerAddress" IS 'Cross-reference table mapping customers to their address(es).';
COMMENT ON COLUMN "SalesLT"."CustomerAddress"."CustomerID" IS 'Primary key. Foreign key to Customer.CustomerID.';
COMMENT ON COLUMN "SalesLT"."CustomerAddress"."AddressID" IS 'Primary key. Foreign key to Address.AddressID.';
COMMENT ON COLUMN "SalesLT"."CustomerAddress"."AddressType" IS 'The kind of Address. One of: Archive, Billing, Home, Main Office, Primary, Shipping';
COMMENT ON COLUMN "SalesLT"."CustomerAddress"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."CustomerAddress"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_CustomerAddress_rowguid" ON "SalesLT"."CustomerAddress" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "PK_CustomerAddress_CustomerID_AddressID" ON "SalesLT"."CustomerAddress" IS 'Primary key (clustered) constraint';
COMMENT ON CONSTRAINT "FK_CustomerAddress_Customer_CustomerID" ON "SalesLT"."CustomerAddress" IS 'Foreign key constraint referencing Customer.CustomerID.';
COMMENT ON CONSTRAINT "FK_CustomerAddress_Address_AddressID" ON "SalesLT"."CustomerAddress" IS 'Foreign key constraint referencing Address.AddressID.';

CREATE TABLE "SalesLT"."ProductCategory" (
    "ProductCategoryID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "ParentProductCategoryID" INT,
    "Name" VARCHAR(50) NOT NULL,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_ProductCategory_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "AK_ProductCategory_Name" UNIQUE ("Name"),
    CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY ("ProductCategoryID"),
    CONSTRAINT "FK_ProductCategory_ProductCategory" FOREIGN KEY("ParentProductCategoryID") REFERENCES "SalesLT"."ProductCategory"("ProductCategoryID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE "SalesLT"."ProductCategory" IS 'High-level product categorization.';
COMMENT ON COLUMN "SalesLT"."ProductCategory"."ProductCategoryID" IS 'Primary key for ProductCategory records.';
COMMENT ON COLUMN "SalesLT"."ProductCategory"."ParentProductCategoryID" IS 'Product category identification number of immediate ancestor category. Foreign key to ProductCategory.ProductCategoryID.';
COMMENT ON COLUMN "SalesLT"."ProductCategory"."Name" IS 'Category description.';
COMMENT ON COLUMN "SalesLT"."ProductCategory"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."ProductCategory"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_ProductCategory_rowguid" ON "SalesLT"."ProductCategory" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "AK_ProductCategory_Name" ON "SalesLT"."ProductCategory" IS 'Unique nonclustered constraint.';
COMMENT ON CONSTRAINT "PK_ProductCategory_ProductCategoryID" ON "SalesLT"."ProductCategory" IS 'Primary key (clustered) constraint';
COMMENT ON CONSTRAINT "FK_ProductCategory_ProductCategory" ON "SalesLT"."ProductCategory" IS 'Foreign key constraint referencing ProductCategory.ProductCategoryID.';

CREATE TABLE "SalesLT"."ProductModel" (
    "ProductModelID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Name" VARCHAR(50) NOT NULL,
    "CatalogDescription" TEXT,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_ProductModel_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY ("ProductModelID")
);
COMMENT ON COLUMN "SalesLT"."ProductModel"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."ProductModel"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_ProductModel_rowguid" ON "SalesLT"."ProductModel" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "PK_ProductModel_ProductModelID" ON "SalesLT"."ProductModel" IS 'Clustered index created by a primary key constraint.';

CREATE TABLE "SalesLT"."ProductDescription" (
    "ProductDescriptionID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Description" VARCHAR(400) NOT NULL,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_ProductDescription_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY ("ProductDescriptionID")
);
COMMENT ON TABLE "SalesLT"."ProductDescription" IS 'Product descriptions in several languages.';
COMMENT ON COLUMN "SalesLT"."ProductDescription"."ProductDescriptionID" IS 'Primary key for ProductDescription records.';
COMMENT ON COLUMN "SalesLT"."ProductDescription"."Description" IS 'Description of the product.';
COMMENT ON COLUMN "SalesLT"."ProductDescription"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."ProductDescription"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_ProductDescription_rowguid" ON "SalesLT"."ProductDescription" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "PK_ProductDescription_ProductDescriptionID" ON "SalesLT"."ProductDescription" IS 'Primary key (clustered) constraint';

CREATE TABLE "SalesLT"."ProductModelProductDescription" (
    "ProductModelID" INT NOT NULL,
    "ProductDescriptionID" INT NOT NULL,
    "Culture" CHAR(6) NOT NULL,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_ProductModelProductDescription_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "PK_ProductModelProductDescription" PRIMARY KEY ("ProductModelID", "ProductDescriptionID", "Culture"),
    CONSTRAINT "FK_ProductModelProductDescription_ProductModel" FOREIGN KEY("ProductModelID") REFERENCES "SalesLT"."ProductModel"("ProductModelID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "FK_ProductModelProductDescription_ProductDescription" FOREIGN KEY("ProductDescriptionID") REFERENCES "SalesLT"."ProductDescription"("ProductDescriptionID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE "SalesLT"."ProductModelProductDescription" IS 'Cross-reference table mapping product descriptions and the language the description is written in.';
COMMENT ON COLUMN "SalesLT"."ProductModelProductDescription"."ProductModelID" IS 'Primary key. Foreign key to ProductModel.ProductModelID.';
COMMENT ON COLUMN "SalesLT"."ProductModelProductDescription"."ProductDescriptionID" IS 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';
COMMENT ON COLUMN "SalesLT"."ProductModelProductDescription"."Culture" IS 'The culture for which the description is written.';
COMMENT ON COLUMN "SalesLT"."ProductModelProductDescription"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."ProductModelProductDescription"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_ProductModelProductDescription_rowguid" ON "SalesLT"."ProductModelProductDescription" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "PK_ProductModelProductDescription" ON "SalesLT"."ProductModelProductDescription" IS 'Primary key (clustered) constraint';
COMMENT ON CONSTRAINT "FK_ProductModelProductDescription_ProductModel" ON "SalesLT"."ProductModelProductDescription" IS 'Foreign key constraint referencing ProductModel.ProductModelID.';
COMMENT ON CONSTRAINT "FK_ProductModelProductDescription_ProductDescription" ON "SalesLT"."ProductModelProductDescription" IS 'Foreign key constraint referencing ProductDescription.ProductDescriptionID.';

CREATE TABLE "SalesLT"."Product" (
    "ProductID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Name" VARCHAR(50) NOT NULL,
    "ProductNumber" VARCHAR(25) NOT NULL,
    "Color" VARCHAR(15),
    "StandardCost" MONEY NOT NULL,
    "ListPrice" MONEY NOT NULL,
    "Size" VARCHAR(5),
    "Weight" DECIMAL(8, 2),
    "ProductCategoryID" INT NOT NULL,
    "ProductModelID" INT NOT NULL,
    "SellStartDate" TIMESTAMP NOT NULL,
    "SellEndDate" TIMESTAMP,
    "DiscontinuedDate" TIMESTAMP,
    "ThumbNailPhoto" BYTEA,
    "ThumbnailPhotoFileName" VARCHAR(50),
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_Product_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "CK_Product_ListPrice" CHECK ("ListPrice" >= '0'::money),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (("SellEndDate" >= "SellStartDate") OR ("SellEndDate" IS NULL)),
    CONSTRAINT "CK_Product_StandardCost" CHECK ("StandardCost" >= '0'::money),
    CONSTRAINT "CK_Product_Weight" CHECK ("Weight" >= 0),
    CONSTRAINT "AK_Product_Name" UNIQUE ("Name"),
    CONSTRAINT "AK_Product_ProductNumber" UNIQUE ("ProductNumber"),
    CONSTRAINT "PK_Product_ProductID" PRIMARY KEY ("ProductID"),
    CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY("ProductModelID") REFERENCES "SalesLT"."ProductModel"("ProductModelID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "FK_Product_ProductCategory_ProductCategoryID" FOREIGN KEY("ProductCategoryID") REFERENCES "SalesLT"."ProductCategory"("ProductCategoryID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
COMMENT ON TABLE "SalesLT"."Product" IS 'Products sold or used in the manfacturing of sold products.';
COMMENT ON COLUMN "SalesLT"."Product"."ProductID" IS 'Primary key for Product records.';
COMMENT ON COLUMN "SalesLT"."Product"."Name" IS 'Name of the product.';
COMMENT ON COLUMN "SalesLT"."Product"."ProductNumber" IS 'Unique product identification number.';
COMMENT ON COLUMN "SalesLT"."Product"."Color" IS 'Product color.';
COMMENT ON COLUMN "SalesLT"."Product"."StandardCost" IS 'Standard cost of the product.';
COMMENT ON COLUMN "SalesLT"."Product"."ListPrice" IS 'Selling price.';
COMMENT ON COLUMN "SalesLT"."Product"."Size" IS 'Product size.';
COMMENT ON COLUMN "SalesLT"."Product"."Weight" IS 'Product weight.';
COMMENT ON COLUMN "SalesLT"."Product"."ProductCategoryID" IS 'Product is a member of this product category. Foreign key to ProductCategory.ProductCategoryID.';
COMMENT ON COLUMN "SalesLT"."Product"."ProductModelID" IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';
COMMENT ON COLUMN "SalesLT"."Product"."SellStartDate" IS 'Date the product was available for sale.';
COMMENT ON COLUMN "SalesLT"."Product"."SellEndDate" IS 'Date the product was no longer available for sale.';
COMMENT ON COLUMN "SalesLT"."Product"."DiscontinuedDate" IS 'Date the product was discontinued.';
COMMENT ON COLUMN "SalesLT"."Product"."ThumbNailPhoto" IS 'Small image of the product.';
COMMENT ON COLUMN "SalesLT"."Product"."ThumbnailPhotoFileName" IS 'Small image file name.';
COMMENT ON COLUMN "SalesLT"."Product"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."Product"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_Product_rowguid" ON "SalesLT"."Product" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "CK_Product_ListPrice" ON "SalesLT"."Product" IS 'Check constraint [ListPrice] >= (0.00)';
COMMENT ON CONSTRAINT "CK_Product_SellEndDate" ON "SalesLT"."Product" IS 'Check constraint [SellEndDate] >= [SellStartDate] OR [SellEndDate] IS NULL';
COMMENT ON CONSTRAINT "CK_Product_Weight" ON "SalesLT"."Product" IS 'Check constraint [Weight] >= (0.00)';
COMMENT ON CONSTRAINT "AK_Product_Name" ON "SalesLT"."Product" IS 'Unique nonclustered constraint.';
COMMENT ON CONSTRAINT "AK_Product_ProductNumber" ON "SalesLT"."Product" IS 'Unique nonclustered constraint.';
COMMENT ON CONSTRAINT "PK_Product_ProductID" ON "SalesLT"."Product" IS 'Primary key (clustered) constraint';

CREATE TABLE "SalesLT"."SalesOrderHeader" (
    "SalesOrderID" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "RevisionNumber" SMALLINT NOT NULL DEFAULT(0),
    "OrderDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    "DueDate" TIMESTAMP NOT NULL,
    "ShipDate" TIMESTAMP NOT NULL,
    "Status" SMALLINT NOT NULL DEFAULT(1),
    "OnlineOrderFlag" BOOLEAN NOT NULL DEFAULT(FALSE),
    "SalesOrderNumber" VARCHAR(25) GENERATED ALWAYS AS ('SO' || CAST("SalesOrderID" AS VARCHAR(23))) STORED,
    "PurchaseOrderNumber" VARCHAR(25) NOT NULL,
    "AccountNumber" VARCHAR(15) NOT NULL,
    "CustomerID" INT NOT NULL,
    "ShipToAddressID" INT NOT NULL,
    "BillToAddressID" INT NOT NULL,
    "ShipMethod" VARCHAR(50) NOT NULL,
    "CreditCardApprovalCode" VARCHAR(15),
    "SubTotal" MONEY NOT NULL DEFAULT(0),
    "TaxAmt" MONEY NOT NULL DEFAULT(0),
    "Freight" MONEY NOT NULL DEFAULT(0),
    "TotalDue" MONEY GENERATED ALWAYS AS ("SubTotal" + "TaxAmt" + "Freight") STORED,
    "Comment" TEXT,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_SalesOrderHeader_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ("DueDate" >= "OrderDate"),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK ("Freight" >= '0'::money),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (("ShipDate" >= "OrderDate") OR ("ShipDate" IS NULL)),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ("SubTotal" >= '0'::money),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ("TaxAmt" >= '0'::money),
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (("Status" >= 1) AND ("Status" <= 6)),
    CONSTRAINT "AK_SalesOrderHeader_SalesOrderNumber" UNIQUE ("SalesOrderNumber"),
    CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY ("SalesOrderID"),
    CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY("CustomerID") REFERENCES "SalesLT"."Customer"("CustomerID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_Address_BillTo_AddressID" FOREIGN KEY("BillToAddressID") REFERENCES "SalesLT"."Address"("AddressID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "FK_SalesOrderHeader_Address_ShipTo_AddressID" FOREIGN KEY("CustomerID", "ShipToAddressID") REFERENCES "SalesLT"."CustomerAddress"("CustomerID", "AddressID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "IX_SalesOrderHeader_CustomerID" ON "SalesLT"."SalesOrderHeader" ("CustomerID");
COMMENT ON TABLE "SalesLT"."SalesOrderHeader" IS 'General sales order information.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."SalesOrderID" IS 'Primary key.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."RevisionNumber" IS 'Incremental number to track changes to the sales order over time.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."OrderDate" IS 'Dates the sales order was created.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."DueDate" IS 'Date the order is due to the customer.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."ShipDate" IS 'Date the order was shipped to the customer.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."Status" IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."OnlineOrderFlag" IS '0 = Order placed by sales person. 1 = Order placed online by customer.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."SalesOrderNumber" IS 'Unique sales order identification number.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."PurchaseOrderNumber" IS 'Customer purchase order number reference.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."AccountNumber" IS 'Financial accounting number reference.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."CustomerID" IS 'Customer identification number. Foreign key to Customer.CustomerID.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."ShipToAddressID" IS 'The ID of the location to send goods.  Foreign key to the Address table.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."BillToAddressID" IS 'The ID of the location to send invoices.  Foreign key to the Address table.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."ShipMethod" IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."CreditCardApprovalCode" IS 'Approval code provided by the credit card company.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."SubTotal" IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."TaxAmt" IS 'Tax amount.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."Freight" IS 'Shipping cost.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."TotalDue" IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."Comment" IS 'Sales representative comments.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."SalesOrderHeader"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_SalesOrderHeader_rowguid" ON "SalesLT"."SalesOrderHeader" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "CK_SalesOrderHeader_DueDate" ON "SalesLT"."SalesOrderHeader" IS 'Check constraint [DueDate] >= [OrderDate]';
COMMENT ON CONSTRAINT "CK_SalesOrderHeader_Freight" ON "SalesLT"."SalesOrderHeader" IS 'Check constraint [Freight] >= (0.00)';
COMMENT ON CONSTRAINT "CK_SalesOrderHeader_ShipDate" ON "SalesLT"."SalesOrderHeader" IS 'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL';
COMMENT ON CONSTRAINT "CK_SalesOrderHeader_SubTotal" ON "SalesLT"."SalesOrderHeader" IS 'Check constraint [SubTotal] >= (0.00)';
COMMENT ON CONSTRAINT "CK_SalesOrderHeader_TaxAmt" ON "SalesLT"."SalesOrderHeader" IS 'Check constraint [TaxAmt] >= (0.00)';
COMMENT ON CONSTRAINT "CK_SalesOrderHeader_Status" ON "SalesLT"."SalesOrderHeader" IS 'Check constraint [Status] BETWEEN (1) AND (6)';
COMMENT ON CONSTRAINT "AK_SalesOrderHeader_SalesOrderNumber" ON "SalesLT"."SalesOrderHeader" IS 'Unique nonclustered constraint.';
COMMENT ON CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" ON "SalesLT"."SalesOrderHeader" IS 'Clustered index created by a primary key constraint.';

CREATE TABLE "SalesLT"."SalesOrderDetail" (
    "SalesOrderID" INT NOT NULL,
    "SalesOrderDetailID" INT NOT NULL,
    "OrderQty" SMALLINT NOT NULL,
    "ProductID" INT NOT NULL,
    "UnitPrice" MONEY NOT NULL,
    "UnitPriceDiscount" DECIMAL(18, 2) NOT NULL DEFAULT(0),
    "LineTotal" MONEY GENERATED ALWAYS AS ("UnitPrice" * (1 - "UnitPriceDiscount") * CAST("OrderQty" AS DECIMAL(18, 2))) STORED,
    "RowGuid" UUID NOT NULL DEFAULT(GEN_RANDOM_UUID()),
    "ModifiedDate" TIMESTAMP NOT NULL DEFAULT(NOW()),
    CONSTRAINT "AK_SalesOrderDetail_rowguid" UNIQUE ("RowGuid"),
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ("OrderQty" > 0),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ("UnitPrice" >= '0'::money),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ("UnitPriceDiscount" >= 0),
    CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY ("SalesOrderID", "SalesOrderDetailID"),
    CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader" FOREIGN KEY("SalesOrderID") REFERENCES "SalesLT"."SalesOrderHeader"("SalesOrderID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "FK_SalesOrderDetail_Product" FOREIGN KEY("ProductID") REFERENCES "SalesLT"."Product"("ProductID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE INDEX "IX_SalesOrderDetail_ProductID" ON "SalesLT"."SalesOrderDetail" ("ProductID");
COMMENT ON TABLE "SalesLT"."SalesOrderDetail" IS 'Individual products associated with a specific sales order. See SalesOrderHeader.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."SalesOrderID" IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."SalesOrderDetailID" IS 'Primary key. One incremental unique number per product sold.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."OrderQty" IS 'Quantity ordered per product.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."ProductID" IS 'Product sold to customer. Foreign key to Product.ProductID.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."UnitPrice" IS 'Selling price of a single product.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."UnitPriceDiscount" IS 'Discount amount.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."LineTotal" IS 'Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."RowGuid" IS 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
COMMENT ON COLUMN "SalesLT"."SalesOrderDetail"."ModifiedDate" IS 'Date and time the record was last updated.';
COMMENT ON CONSTRAINT "AK_SalesOrderDetail_rowguid" ON "SalesLT"."SalesOrderDetail" IS 'Unique nonclustered constraint. Used to support replication samples.';
COMMENT ON CONSTRAINT "CK_SalesOrderDetail_OrderQty" ON "SalesLT"."SalesOrderDetail" IS 'Check constraint [OrderQty] > (0)';
COMMENT ON CONSTRAINT "CK_SalesOrderDetail_UnitPrice" ON "SalesLT"."SalesOrderDetail" IS 'Check constraint [UnitPrice] >= (0.00)';
COMMENT ON CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" ON "SalesLT"."SalesOrderDetail" IS 'Check constraint [UnitPriceDiscount] >= (0.00)';
COMMENT ON CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" ON "SalesLT"."SalesOrderDetail" IS 'Clustered index created by a primary key constraint.';

COPY "SalesLT"."Address"
FROM 'SalesLT.Address.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."Customer"
FROM 'SalesLT.Customer.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."CustomerAddress"
FROM 'SalesLT.CustomerAddress.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."ProductCategory"
FROM 'SalesLT.ProductCategory.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."ProductModel"
FROM 'SalesLT.ProductModel.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."ProductDescription"
FROM 'SalesLT.ProductDescription.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."ProductModelProductDescription"
FROM 'SalesLT.ProductModelProductDescription.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."Product"
FROM 'SalesLT.Product.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."SalesOrderHeader"
FROM 'SalesLT.SalesOrderHeader.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

COPY "SalesLT"."SalesOrderDetail"
FROM 'SalesLT.SalesOrderDetail.csv'
WITH DELIMITER ',' NULL 'NULL' CSV HEADER;

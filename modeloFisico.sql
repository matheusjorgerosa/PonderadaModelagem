CREATE TABLE IF NOT EXISTS "users" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"Names" text NOT NULL,
	"Emails" text NOT NULL,
	"Passwords" text NOT NULL,
	"AccessLevels" boolean NOT NULL,
	PRIMARY KEY ("Ids")
);

CREATE TABLE IF NOT EXISTS "Handbooks" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"AssociatedProductIds" bigint NOT NULL,
	"Names" text NOT NULL,
	"Descriptions" text NOT NULL,
	"UploadDates" timestamp with time zone NOT NULL,
	"AdditionalFilesIds" bigint NOT NULL,
	"PublicationDates" timestamp with time zone NOT NULL,
	PRIMARY KEY ("Ids")
);

CREATE TABLE IF NOT EXISTS "Tasks" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"AssemblerIds" bigint NOT NULL,
	"AssociatedHandbookIds" bigint NOT NULL,
	"IsFinished" boolean NOT NULL,
	"UploadDates" timestamp with time zone NOT NULL,
	"AssociatedAdminIds" bigint NOT NULL,
	PRIMARY KEY ("Ids")
);

CREATE TABLE IF NOT EXISTS "Favorites" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"UserIds" bigint NOT NULL,
	"HandbookIds" bigint NOT NULL,
	"HandbookDescriptions" text NOT NULL,
	"HandbookNames" text NOT NULL,
	PRIMARY KEY ("Ids")
);

CREATE TABLE IF NOT EXISTS "AssemblyLine" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"Names" text NOT NULL,
	"Descriptions" text NOT NULL,
	"AssociatedUserId" bigint NOT NULL,
	PRIMARY KEY ("Ids")
);

CREATE TABLE IF NOT EXISTS "Products" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"Names" text NOT NULL,
	"AssociatedAssembleLineId" bigint NOT NULL,
	PRIMARY KEY ("Ids")
);

CREATE TABLE IF NOT EXISTS "AdditionalFiles" (
	"Ids" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"AssociatedPublicationDates" timestamp with time zone NOT NULL,
	"TypesOfFiles" text NOT NULL,
	"FilesPath" text NOT NULL,
	PRIMARY KEY ("Ids")
);


ALTER TABLE "Handbooks" ADD CONSTRAINT "Handbooks_fk1" FOREIGN KEY ("AssociatedProductIds") REFERENCES "Products"("Ids");

ALTER TABLE "Handbooks" ADD CONSTRAINT "Handbooks_fk5" FOREIGN KEY ("AdditionalFilesIds") REFERENCES "AdditionalFiles"("Ids");
ALTER TABLE "Tasks" ADD CONSTRAINT "Tasks_fk1" FOREIGN KEY ("AssemblerIds") REFERENCES "users"("Ids");

ALTER TABLE "Tasks" ADD CONSTRAINT "Tasks_fk2" FOREIGN KEY ("AssociatedHandbookIds") REFERENCES "Handbooks"("Ids");

ALTER TABLE "Tasks" ADD CONSTRAINT "Tasks_fk5" FOREIGN KEY ("AssociatedAdminIds") REFERENCES "users"("Ids");
ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_fk1" FOREIGN KEY ("UserIds") REFERENCES "users"("Ids");

ALTER TABLE "Favorites" ADD CONSTRAINT "Favorites_fk2" FOREIGN KEY ("HandbookIds") REFERENCES "Handbooks"("Ids");
ALTER TABLE "AssemblyLine" ADD CONSTRAINT "AssemblyLine_fk3" FOREIGN KEY ("AssociatedUserId") REFERENCES "users"("Ids");
ALTER TABLE "Products" ADD CONSTRAINT "Products_fk2" FOREIGN KEY ("AssociatedAssembleLineId") REFERENCES "AssembleLine"("Ids");
```
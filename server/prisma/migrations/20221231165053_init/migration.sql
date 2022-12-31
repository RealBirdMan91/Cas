/*
  Warnings:

  - You are about to drop the column `rolesId` on the `RegionsPermissions` table. All the data in the column will be lost.
  - You are about to drop the column `rolesId` on the `RolesPermissions` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[createRegionsId]` on the table `Roles` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[createRolesId]` on the table `Roles` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `createRegionsId` to the `Roles` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createRolesId` to the `Roles` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "RegionsPermissions" DROP CONSTRAINT "RegionsPermissions_rolesId_fkey";

-- DropForeignKey
ALTER TABLE "RolesPermissions" DROP CONSTRAINT "RolesPermissions_rolesId_fkey";

-- DropIndex
DROP INDEX "RegionsPermissions_rolesId_key";

-- DropIndex
DROP INDEX "RolesPermissions_rolesId_key";

-- AlterTable
ALTER TABLE "RegionsPermissions" DROP COLUMN "rolesId";

-- AlterTable
ALTER TABLE "Roles" ADD COLUMN     "createRegionsId" TEXT NOT NULL,
ADD COLUMN     "createRolesId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "RolesPermissions" DROP COLUMN "rolesId";

-- CreateTable
CREATE TABLE "Employee" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rolesId" TEXT NOT NULL,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Roles_createRegionsId_key" ON "Roles"("createRegionsId");

-- CreateIndex
CREATE UNIQUE INDEX "Roles_createRolesId_key" ON "Roles"("createRolesId");

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_rolesId_fkey" FOREIGN KEY ("rolesId") REFERENCES "Roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Roles" ADD CONSTRAINT "Roles_createRegionsId_fkey" FOREIGN KEY ("createRegionsId") REFERENCES "RegionsPermissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Roles" ADD CONSTRAINT "Roles_createRolesId_fkey" FOREIGN KEY ("createRolesId") REFERENCES "RolesPermissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

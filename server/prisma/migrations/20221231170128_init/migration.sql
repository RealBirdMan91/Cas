/*
  Warnings:

  - You are about to drop the column `rolesId` on the `Employee` table. All the data in the column will be lost.
  - You are about to drop the `Roles` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `roleId` to the `Employee` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Employee" DROP CONSTRAINT "Employee_rolesId_fkey";

-- DropForeignKey
ALTER TABLE "Roles" DROP CONSTRAINT "Roles_createRegionsId_fkey";

-- DropForeignKey
ALTER TABLE "Roles" DROP CONSTRAINT "Roles_createRolesId_fkey";

-- AlterTable
ALTER TABLE "Employee" DROP COLUMN "rolesId",
ADD COLUMN     "roleId" TEXT NOT NULL;

-- DropTable
DROP TABLE "Roles";

-- CreateTable
CREATE TABLE "Role" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "regionPermissionsId" TEXT NOT NULL,
    "rolePermissionsId" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Role_regionPermissionsId_key" ON "Role"("regionPermissionsId");

-- CreateIndex
CREATE UNIQUE INDEX "Role_rolePermissionsId_key" ON "Role"("rolePermissionsId");

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Role" ADD CONSTRAINT "Role_regionPermissionsId_fkey" FOREIGN KEY ("regionPermissionsId") REFERENCES "RegionsPermissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Role" ADD CONSTRAINT "Role_rolePermissionsId_fkey" FOREIGN KEY ("rolePermissionsId") REFERENCES "RolesPermissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

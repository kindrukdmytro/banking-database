SET search_path TO "lab5";
-- AlterTable
ALTER TABLE "clients" ADD COLUMN     "is_verified" BOOLEAN NOT NULL DEFAULT false;

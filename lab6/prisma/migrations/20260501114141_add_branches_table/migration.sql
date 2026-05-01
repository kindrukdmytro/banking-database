SET search_path TO "lab5";
-- CreateTable
CREATE TABLE "branches" (
    "branch_id" SERIAL NOT NULL,
    "branch_name" VARCHAR(100) NOT NULL,
    "city" VARCHAR(50) NOT NULL,
    "address" VARCHAR(150) NOT NULL,
    "created_at" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "branches_pkey" PRIMARY KEY ("branch_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "branches_branch_name_key" ON "branches"("branch_name");

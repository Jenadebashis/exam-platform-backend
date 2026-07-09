-- CreateTable
CREATE TABLE "MockTest" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "durationMinutes" INTEGER NOT NULL,
    "status" "MockTestStatus" NOT NULL DEFAULT 'DRAFT',
    "maxAttempts" INTEGER,
    "publishedAt" TIMESTAMP(3),
    "createdById" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "MockTest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MockTestSection" (
    "id" TEXT NOT NULL,
    "mockTestId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL,
    "durationMinutes" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "MockTestSection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MockTestQuestion" (
    "mockTestId" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL,
    "marksOverride" DOUBLE PRECISION,
    "negativeMarksOverride" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MockTestQuestion_pkey" PRIMARY KEY ("mockTestId","questionId")
);

-- CreateIndex
CREATE INDEX "MockTest_status_idx" ON "MockTest"("status");

-- CreateIndex
CREATE INDEX "MockTest_createdById_idx" ON "MockTest"("createdById");

-- CreateIndex
CREATE INDEX "MockTestSection_mockTestId_idx" ON "MockTestSection"("mockTestId");

-- CreateIndex
CREATE UNIQUE INDEX "MockTestSection_mockTestId_name_key" ON "MockTestSection"("mockTestId", "name");

-- CreateIndex
CREATE INDEX "MockTestQuestion_questionId_idx" ON "MockTestQuestion"("questionId");

-- CreateIndex
CREATE INDEX "MockTestQuestion_sectionId_idx" ON "MockTestQuestion"("sectionId");

-- CreateIndex
CREATE UNIQUE INDEX "MockTestQuestion_sectionId_sortOrder_key" ON "MockTestQuestion"("sectionId", "sortOrder");

-- AddForeignKey
ALTER TABLE "MockTest" ADD CONSTRAINT "MockTest_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MockTestSection" ADD CONSTRAINT "MockTestSection_mockTestId_fkey" FOREIGN KEY ("mockTestId") REFERENCES "MockTest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MockTestQuestion" ADD CONSTRAINT "MockTestQuestion_mockTestId_fkey" FOREIGN KEY ("mockTestId") REFERENCES "MockTest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MockTestQuestion" ADD CONSTRAINT "MockTestQuestion_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MockTestQuestion" ADD CONSTRAINT "MockTestQuestion_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "MockTestSection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

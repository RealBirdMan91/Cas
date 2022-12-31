import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function seed() {
  await prisma.role.deleteMany();

  const roleOne = await prisma.role.create({
    data: {
      name: "Admin",
      regionPermissions: {
        create: {
          create: true,
          read: true,
          update: true,
          delete: true,
        },
      },
      rolePermissions: {
        create: {
          create: true,
          read: true,
          update: true,
          delete: true,
        },
      },
    },
  });

  const roleTwo = await prisma.role.create({
    data: {
      name: "Employee",
      regionPermissions: {
        create: {
          create: false,
          read: true,
          update: false,
          delete: false,
        },
      },
      rolePermissions: {
        create: {
          create: false,
          read: false,
          update: false,
          delete: false,
        },
      },
    },
  });

  const roles = await prisma.role.findMany({
    include: {
      regionPermissions: true,
      rolePermissions: true
    },
  });

  console.log(roles);
}

seed();

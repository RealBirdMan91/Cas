import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function seed() {
  //await prisma.roles.deleteMany();

  const roleOne = await prisma.roles.create({
    data: {
      name: "Bob",
      canCreateRoles: {
        create: {
          create: true,
          read: true,
          update: true,
          delete: false,
        },
      },
      canCreateRegions: {
        create: {
          create: false,
          read: true,
          update: false,
          delete: false,
        },
      },
    },
  });

  const roleTwo = await prisma.roles.create({
    data: {
      name: "Mikel",
      canCreateRoles: {
        create: {
          create: false,
          read: false,
          update: true,
          delete: true,
        },
      },
      canCreateRegions: {
        create: {
          create: false,
          read: true,
          update: true,
          delete: false,
        },
      },
    },
  });

 const roles = await prisma.roles.findMany({
    include: {
        canCreateRegions: true, 
        canCreateRoles: true
    }
 })

 console.log(roles)
}

seed();
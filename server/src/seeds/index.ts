import { seedUsers } from './user-seeds.js';
import { seedRole_types } from './role_type-seeds.js';
import sequelize from '../config/connection.js';

const seedAll = async (): Promise<void> => {
  try {
    await sequelize.sync({ force: true });
    console.log('\n----- DATABASE SYNCED -----\n');

    await seedRole_types();
    console.log('\n----- ROLE_TYPES SEEDED -----\n');

    await seedUsers();
    console.log('\n----- USERS SEEDED -----\n');

    process.exit(0);
  } catch (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  }
};

seedAll();

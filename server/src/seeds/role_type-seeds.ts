import { Role_type } from '../models/index.js';

export const seedRole_types = async () => {
  await Role_type.bulkCreate(
    [
      { description: 'Instructor' },
      { description: 'Guardian' },
      { description: 'Student' },
    ],
    { individualHooks: true }
  );
};

import { User } from '../models/index.js';

export const seedUsers = async () => {
  await User.bulkCreate(
    [
      { 
        username: 'Dr.Science', 
        email: 'dr.science@school.com', 
        password: 'password', 
        role_type_id: 1, // Instructor
      },
      {
        username: 'SuperMom',
        email: 'SuperMom@parents.com',
        password: 'password',
        role_type_id: 2, //Guardian
      },
      {
        username: 'SchoolBoy',
        email: 'SchoolBoy@students.com',
        password: 'password',
        role_type_id: 3, // Student
      },
    ],
    { individualHooks: true }
  );
};

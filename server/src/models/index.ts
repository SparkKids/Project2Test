import sequelize from '../config/connection.js';
import { UserFactory } from './user.js';
import { Role_typeFactory } from './role_type.js';

const User = UserFactory(sequelize);
const Role_type = Role_typeFactory(sequelize);

export { sequelize, User, Role_type};



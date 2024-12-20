const User = require('./user');
const Role_type = require('./role_type');

// Define the one-to-many relationship
User.belongsTo(Role_type, {
  foreignKey: 'role_type_id', // This is the foreign key in the User model
  allowNull: false,
 });

 Role_type.hasMany(User, {
  foreignKey: { 
    name: 'role_type_id',  // This is the foreign key in the User model
    onDelete: 'SET NULL',   // Optional: what happens when a Role_type is deleted
    onUpdate: 'CASCADE',    // Optional: what happens when the primary key is upated
  }
 });
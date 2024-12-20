import { DataTypes, Sequelize, Model } from 'sequelize';
import bcrypt from 'bcrypt';
type Optional<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;


interface UserAttributes {
  user_id: number;
  username: string;
  password: string;
  email: string;
  role_type_id: number;
}

interface UserCreationAttributes extends Optional<UserAttributes, 'user_id'> {}

export class User extends Model<UserAttributes, UserCreationAttributes> implements UserAttributes {
    public user_id!: number;
  public username!: string;
  public password!: string;
  public email!: string;
  public role_type_id: number;
  public readonly createdAt!: Date;
  public readonly updatedAt!: Date;

  // Hash the password before saving the user
  public async setPassword(password: string) {
    const saltRounds = 10;
    this.password = await bcrypt.hash(password, saltRounds);
  }
}

export function UserFactory(sequelize: Sequelize): typeof User {
  User.init(
    {
      user_id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
      },
      username: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
      },

      password: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      role_type_id: {
        type: DataTypes.NUMBER,
        allowNull: false,
      },
    },
    {
      tableName: 'users',
      sequelize,
      hooks: {
        beforeCreate: async (user: User) => {
          await user.setPassword(user.password);
        },
        beforeUpdate: async (user: User) => {
          await user.setPassword(user.password);
        },
      }
    }
  );

  return User;
}

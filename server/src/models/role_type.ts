import { DataTypes, Sequelize, Model } from 'sequelize';
type Optional<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;


interface Role_typeAttributes {
  role_type_id: number;
  description: string;
}

interface Role_typeCreationAttributes extends Optional<Role_typeAttributes, 'role_type_id'> {}

export class Role_type extends Model<Role_typeAttributes, Role_typeCreationAttributes> implements Role_typeAttributes {
    public role_type_id!: number;
  public description!: string;
  public readonly createdAt!: Date;
  public readonly updatedAt!: Date;

 }


export function Role_typeFactory(sequelize: Sequelize): typeof Role_type {
    Role_type.init(
    {
      role_type_id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
      },
      description: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      tableName: 'role_types',
      sequelize,
    }
  );

  return Role_type;
}

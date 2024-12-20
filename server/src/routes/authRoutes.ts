import { Router, type Request, type Response, type NextFunction } from 'express';
import { User } from '../models/index.js';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';

export const login = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  const { username, password } = req.body;

  try {
    const user = await User.findOne({
      where: { username },
    });

    if (!user) {
      res.status(401).json({ message: 'Authentication failed' }); // Just call the method without return
      return; // Exit the function after sending the response
    }

    const passwordIsValid = await bcrypt.compare(password, user.password);
    if (!passwordIsValid) {
      res.status(401).json({ message: 'Authentication failed' }); // Just call the method without return
      return; // Exit the function after sending the response
    }

    const secretKey = process.env.JWT_SECRET_KEY || '';

    const token = jwt.sign({ username }, secretKey, { expiresIn: '1h' });

    res.json({ token }); // This can remain as is, since you want to send the token
  } catch (error) {
    next(error); // Pass the error to the next middleware
  }
};

const router = Router();

// POST /login - Login a user
router.post('/login', login);

export default router;
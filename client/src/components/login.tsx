import React, { useState } from 'react';
import { Form, Button } from 'react-bootstrap';


const Login: React.FC = () => {
  const [role, setRole] = useState<'Instructor' | 'Parent' | null>(null);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = () => {
    if (!role) {
      alert('Please select a role!');
      return;
    }
    alert(`Logging in as ${role} with username: ${username}`);
  };

  return (
    <div className="card p-4">
      <div className="mb-3">
        <h2>Select Role</h2>
        <Button variant="primary" className="me-2" onClick={() => setRole('Instructor')}>
          Instructor
        </Button>
        <Button variant="secondary" onClick={() => setRole('Parent')}>
          Parent/Guardian
        </Button>
      </div>
      {role && (
        <>
          <h3>Login as {role}</h3>
          <Form>
            <Form.Group className="mb-3" controlId="formUsername">
              <Form.Label>Username</Form.Label>
              <Form.Control
                type="text"
                placeholder="Enter username"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
              />
            </Form.Group>
            <Form.Group className="mb-3" controlId="formPassword">
              <Form.Label>Password</Form.Label>
              <Form.Control
                type="password"
                placeholder="Password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </Form.Group>
            <Button variant="success" onClick={handleLogin}>
              Login
            </Button>
          </Form>
        </>
      )}
    </div>
  );
};

export default Login;